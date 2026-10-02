#!/bin/bash
vids=(
  "/Users/preethy/Downloads/Priyathama_20240128_173515.mp4"
  "/Users/preethy/Documents/profile/assets/Naalona Pongenu_20240128_174610.mp4"
  "/Users/preethy/Documents/profile/assets/Chaleya_Fleamarkets.mp4"
)

out_vids=(
  "docs/assets/media/flea_priyathama.mp4"
  "docs/assets/media/flea_naalona.mp4"
  "docs/assets/media/flea_chaleya.mp4"
)

out_posters=(
  "docs/assets/media/flea_priyathama_poster.jpg"
  "docs/assets/media/flea_naalona_poster.jpg"
  "docs/assets/media/flea_chaleya_poster.jpg"
)

for i in "${!vids[@]}"; do
  input="${vids[$i]}"
  out_video="${out_vids[$i]}"
  out_poster="${out_posters[$i]}"
  
  echo "Processing $input..."
  
  # Check if file exists
  if [ ! -f "$input" ]; then
    echo "File not found: $input"
    continue
  fi

  ffmpeg -y -i "$input" -c:v libx264 -crf 28 -preset fast -c:a aac -b:a 128k "$out_video"
  ffmpeg -y -i "$out_video" -ss 00:00:01 -vframes 1 "$out_poster"
done

echo "Done!"
