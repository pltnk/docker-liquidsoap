#HISTORY.md
History for docker-liquidsoap

This is a history of why changes were made, when searching through commits may not fully explain

#2026-11-12
- Moved to Ubuntu resolute to ensure longer LTS support
- Disabled taglib, because liquidsoap has abandoned taglib for internal tools.
- enabled ffmpeg by default
- moved opam to a separate builder image to decreate image size to compensate for larger size with ffmpeg.
