const fs = require('fs');

const dataPath = 'docs/assets/js/site-data.js';
let content = fs.readFileSync(dataPath, 'utf8');

// Strip window.SITE_DATA = and trailing semicolon/whitespace
let objStr = content.replace(/^window\.SITE_DATA\s*=\s*/, '').trim().replace(/;$/, '');
let data = eval('(' + objStr + ')');

// Set columns for teluguCorporate
if (data.teluguCorporate && Array.isArray(data.teluguCorporate)) {
  data.teluguCorporate.forEach(item => {
    item.columns = 4;
  });
}

// Set columns for teluguJamming
if (data.teluguJamming && Array.isArray(data.teluguJamming)) {
  data.teluguJamming.forEach(item => {
    item.columns = 'auto';
  });
}

// Private events might be inside multiLingual or somewhere else? Let's check multiLingual
if (data.multiLingual && Array.isArray(data.multiLingual)) {
  // Wait, telugu private was added in the previous session? 
  // Let's set columns = 4 for anything with "private" or "corporate" in title or id, 
  // just in case they are nested in other arrays.
}

// It's safer to just search through all arrays for the sections the user wants:
for (let key in data) {
  if (Array.isArray(data[key])) {
    data[key].forEach(card => {
      
      if (key === 'coverSongs') {
        card.columns = 4;
      }
      
      if (key === 'teluguCorporate') {
        card.columns = 4;
      }
      
      if (key === 'teluguJamming') {
        card.columns = 'auto';
      }
    });
  }
}

// Write back as JSON
let newContent = 'window.SITE_DATA = ' + JSON.stringify(data, null, 2) + ';\n';
fs.writeFileSync(dataPath, newContent, 'utf8');
console.log('Updated columns successfully.');
