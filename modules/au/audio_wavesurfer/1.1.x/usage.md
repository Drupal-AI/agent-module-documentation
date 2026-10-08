Audio Wavesurfer renders Drupal media audio files as an interactive waveform player using the wavesurfer.js library, with an optional FFmpeg-backed pre-computed waveform for fast rendering of long files.

---

Audio Wavesurfer adds a field formatter, "Audio Wavesurfer Formatter", that applies to file fields on the `audio` media bundle and displays the audio as a play/pause waveform player powered by wavesurfer.js (v7). The wavesurfer library loads from the jsDelivr CDN by default, or from a local path set on the settings form at `/admin/config/audio_wavesurfer/settings`, where you also configure waveform/progress/cursor colors and bar width/gap/radius. An optional "Waveform Storage" mode uses FFmpeg's `ffprobe` to pre-calculate waveform peak data when an audio media item is saved (via media insert/update hooks), persisting the peaks to a sidecar `.json` file and a lightweight `waveform` content entity keyed by audio file id; when "Waveform Usage" is on, the formatter attaches those stored peaks to `drupalSettings` so the browser renders instantly instead of decoding the audio client-side. The bundled sub-module `audio_wavesurfer_clips` builds on this to let editors mark clip regions on the waveform (requires the separate Audio Clips API module).

---

- Display an audio media item as an interactive waveform player instead of the plain HTML5 `<audio>` element.
- Add waveform playback to any file field on the `audio` media bundle via Manage display → "Audio Wavesurfer Formatter".
- Provide a modern play/pause button with a scrubbable waveform and elapsed/total time readout.
- Show a hover cursor line over the waveform (wavesurfer hover plugin) for precise seeking.
- Brand the player by setting waveform color, progress color, and cursor color on the settings form.
- Tune the visual bar style (bar width, bar gap, bar radius in px) to match your theme.
- Serve the wavesurfer.js library from a CDN with zero local install for quick evaluation.
- Self-host the wavesurfer.js library from a local path (e.g. an npm-installed `dist` directory) to avoid CDN dependencies.
- Pre-compute waveform peaks server-side with FFmpeg so long audio files render their waveform instantly on page load.
- Cache generated waveform peaks in a JSON sidecar file plus a `waveform` entity so peaks are computed once per file, not per view.
- Automatically (re)generate stored waveforms whenever an audio media item is created or updated.
- Control waveform fidelity by setting the number of sample points (up to 2000) used for stored peaks.
- Toggle whether the front end uses stored peaks ("Waveform Usage") independently from whether peaks are generated ("Waveform Storage").
- Present multiple audio players on one page, each managing its own play state (only one plays at a time).
- Use it as the display formatter for podcast episodes, music tracks, interview recordings, or voice notes stored as media.
- Combine with the `audio_wavesurfer_clips` sub-module to let editors define named clip regions (intro, chorus, highlight) over the waveform.
- Support both MP3 and WAV audio sources rendered through the same waveform UI.
- Configure players site-wide from a single settings form under Configuration → Media.
- Keep the front-end JavaScript lightweight by delegating peak calculation to the server when FFmpeg is available.
