# Permissions

`video_embed_field.permissions.yml`:

- **never autoplay videos** — Roles granted this permission never get autoplay, regardless of
  a formatter's `autoplay` setting. Checked in the Video formatter via
  `$this->currentUser->hasPermission('never autoplay videos')`. Use it for accessibility /
  reduced-motion requirements.
