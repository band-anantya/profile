#!/bin/bash
cd docs/assets/media

videos=(
  "telugu_jamming_ee_velalo.mp4"
  "telugu_jamming_manohara.mp4"
  "telugu_jamming_janillikosam.mp4"
  "telugu_jamming_poovullodaagunna.mp4"
)

for vid in "${videos[@]}"; do
  echo "Cropping $vid..."
  
  # Check if file exists
  if [ ! -f "$vid" ]; then
    echo "File $vid not found!"
    continue
  fi

  # Crop to 1080:608, re-encode video, copy audio
  ffmpeg -y -i "$vid" -vf "crop=1080:608:0:656" -c:v libx264 -crf 28 -preset fast -c:a copy "cropped_$vid"
  
  # If successful, replace the original and regenerate poster
  if [ -f "cropped_$vid" ]; then
    mv "cropped_$vid" "$vid"
    
    poster="${vid%.mp4}_poster.jpg"
    echo "Regenerating poster $poster..."
    ffmpeg -y -i "$vid" -ss 00:00:01 -vframes 1 "$poster"
  fi
done

echo "Done!"
