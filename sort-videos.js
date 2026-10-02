const fs = require('fs');

const dataPath = 'docs/assets/js/site-data.js';
let content = fs.readFileSync(dataPath, 'utf8');

// Strip window.SITE_DATA = and trailing semicolon/whitespace
let objStr = content.replace(/^window\.SITE_DATA\s*=\s*/, '').trim().replace(/;$/, '');
let data = eval('(' + objStr + ')');

// Iterate through all arrays in the top-level object
for (let key in data) {
  if (Array.isArray(data[key])) {
    data[key].forEach(card => {
      if (card.videos && Array.isArray(card.videos)) {
        // Sort videos: group by isPortrait
        card.videos.sort((a, b) => {
          // If a is landscape (false) and b is portrait (true), a comes first.
          let valA = a.isPortrait ? 1 : 0;
          let valB = b.isPortrait ? 1 : 0;
          return valA - valB;
        });
      }
    });
  }
}

// Write it back as JSON
let newContent = 'window.SITE_DATA = ' + JSON.stringify(data, null, 2) + ';\n';
fs.writeFileSync(dataPath, newContent, 'utf8');
console.log('Sorted videos successfully.');
