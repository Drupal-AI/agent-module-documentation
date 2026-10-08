<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Streamlike Media field

Three field plugins under `src/Plugin/Field`:

- **FieldType** `streamlike_media_field` (`StreamlikeMediaFieldItem`) — single `value` string property (the Streamlike media ID). `defaultFieldSettings()` sets `cdn_default => 'cdn.streamlike.com'`; `fieldSettingsForm()` exposes it as a "Default Streamlike CDN" textfield. `isEmpty()` is true when `value` is null/empty.
- **FieldWidget** `streamlike_media_field_widget` (`StreamlikeMediaFieldWidget`) — input for the media ID.
- **FieldFormatter** `streamlike_media_field_formatter` (`StreamlikeMediaFieldFormatter`) — renders the Streamlike player embed using the media ID and the field's CDN setting.

Usage: Field UI → add field of type "Streamlike Media" → set CDN under field settings → configure widget (form display) and formatter (display). No config schema-driven admin route; all per-field.
