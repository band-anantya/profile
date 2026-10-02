#!/bin/bash
cd docs/assets/media

videos=(
  "bhajan_om_jai_jagdish.mp4"
  "ganga_jatadhara.mp4"
  "audience_interaction_3.mp4"
)

for vid in "${videos[@]}"; do
  echo "Rotating $vid..."
  
  if [ ! -f "$vid" ]; then
    echo "File $vid not found!"
    continue
  fi

  # Rotate 90 degrees counter-clockwise
  ffmpeg -y -i "$vid" -vf "transpose=2" -c:v libx264 -crf 28 -preset fast -c:a copy "rotated_$vid"
  
  if [ -f "rotated_$vid" ]; then
    mv "rotated_$vid" "$vid"
    
    poster="${vid%.mp4}_poster.jpg"
    echo "Regenerating poster $poster..."
    ffmpeg -y -i "$vid" -ss 00:00:01 -vframes 1 "$poster"
  fi
done

echo "Done!"
