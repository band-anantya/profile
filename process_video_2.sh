#!/bin/bash
input="/Users/preethy/Documents/profile/assets/PriyathamaaC0030_Audienceinteraction.MP4"
out_video="docs/assets/media/audience_interaction_priyathamaa.mp4"
out_poster="docs/assets/media/audience_interaction_priyathamaa_poster.jpg"

echo "Converting video..."
ffmpeg -y -i "$input" -c:v libx264 -crf 28 -preset fast -c:a aac -b:a 128k "$out_video"

echo "Generating poster..."
ffmpeg -y -i "$out_video" -ss 00:00:01 -vframes 1 "$out_poster"

echo "Done!"
ls -lh "$out_video" "$out_poster"
