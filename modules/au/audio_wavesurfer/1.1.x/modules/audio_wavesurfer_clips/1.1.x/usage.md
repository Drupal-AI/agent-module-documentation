Audio Wavesurfer Clip adds a widget and UI that overlay draggable clip regions on the wavesurfer waveform so editors can define start/end times per clip type on an audio media item, backed by the Audio Clips API.

---

Audio Wavesurfer Clip is a sub-module of Audio Wavesurfer. It provides the "Audio Wavesurfer Clip Widget" field widget (extending core's FileWidget) and an `audio_wavesurfer_clip` render/form element that render draggable regions on top of the wavesurfer waveform, one per enabled clip type, with range sliders bound to each region's start and end time. Clip types (their labels and min/max duration constraints) and the actual audio cutting are provided by the separate required Audio Clips API module (`audio_clips`); this sub-module connects that API to the wavesurfer regions UI. When an audio media item is saved, the `AudioPrepareClipService` reads the submitted clip start/end times and creates or updates the matching `audio_clip` entities via the Audio Clips service, optionally regenerating stored waveforms for the resulting clip files when Waveform Storage is enabled. A companion "Audio Wavesurfer Clip Formatter" can display one selected clip type instead of the original audio. Supported audio formats are MP3 and WAV.

---

- Let editors visually mark clip regions (intro, chorus, highlight, teaser) directly on the waveform.
- Define start and end times for a clip by dragging range sliders under the waveform.
- Enable one or more clip types per audio field via the "Audio Wavesurfer Clip Widget" form-display settings.
- Constrain clip length using per-type min/max duration defined on the Audio Clips clip type.
- Auto-size regions: when min/max duration is unset, region length is less constrained; when both are set, it is fixed.
- Persist clips as `audio_clip` entities on media save without a separate save step.
- Update an existing clip's timing simply by moving its region and re-saving the media item.
- Generate the actual cut audio file for each clip through the Audio Clips FFmpeg pipeline.
- Display a specific clip type (instead of the full track) on an entity display with the Audio Wavesurfer Clip Formatter.
- Fall back to the original audio in the clip formatter when no clip type is selected.
- Pre-compute and reuse stored waveforms for clip files when Waveform Storage is on, for instant rendering.
- Offer editors a tabbed UI (horizontal tabs) with one tab per clip type for multi-clip workflows.
- Support podcast editing use cases: mark an intro and an outro clip on each episode.
- Support music previews: define a 30-second highlight clip for each track.
- Support interview archives: extract named excerpts as separate downloadable clips.
- Reuse the same waveform player styling (colors, bars) configured for the parent Audio Wavesurfer module.
- Work with MP3 and WAV source files.
