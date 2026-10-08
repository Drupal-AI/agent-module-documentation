CKEditor 5 Premium Features integrates CKEditor's commercial "Premium Features" (real-time collaboration, track changes, comments, revision history, export/import to Word and PDF, AI assistant, mentions, and more) into Drupal's CKEditor 5 editor. It is the shared base module that holds the license key and CKEditor Cloud Services authentication; each individual feature is shipped as its own thin submodule you enable on demand.

---

This is the foundation module of a suite: on its own it only provides the global settings form and the JWT/token authentication plumbing that every premium feature reuses. The real features live in ~20 submodules (export to PDF/Word, import from Word, real-time collaboration, notifications, AI assistant, mentions, merge fields, footnotes, full-screen mode, the productivity pack, WProofreader, and so on) — you enable only the ones you need. Because these are CKEditor's commercial add-ons, most require a **CKEditor commercial license key** and/or a **CKEditor Cloud Services** subscription (a free trial is available at orders.ckeditor.com). Configuration lives at **Admin → Configuration → CKEditor 5 Premium Features** (`/admin/config/ckeditor5-premium-features/settings`), where you enter the license key and choose an authorization type: an Access key (Environment ID + Access key from the CKEditor dashboard, recommended for production) or a Development token URL (testing only). Once credentials are set and a feature submodule is enabled, you turn the feature on per text format by adding its button/plugin to that format's CKEditor 5 toolbar at Admin → Configuration → Content authoring → Text formats and editors. The module defines two permissions (`use ckeditor5 access token` for cloud/on-prem features and `use ckeditor5 exporters endpoints` for the Word/PDF export endpoints), a `SettingsConfigHandler`, a `TokenGenerator` that mints JWTs for Cloud Services, and base CKEditor 5 plugins (`CloudServices`, `CollaborationBase`, `ExportBase`). Some features also need PHP libraries via Composer suggests (`firebase/php-jwt`, `caxy/php-htmldiff`, `openai-php/client`, `aws/aws-sdk-php`). Real-time collaboration specifically requires the Cloud Services authorization to be configured; track changes and comments can run without real-time collaboration.

---

- Add CKEditor's commercial premium features to a Drupal 11 site's CKEditor 5 editor.
- Store the CKEditor license key and Cloud Services credentials in one central settings form.
- Choose Access-key authorization (Environment ID + Access key) for production real-time features.
- Use a Development token URL for local/testing without full credential validation.
- Enable real-time collaborative editing (requires the realtime_collaboration submodule + Cloud Services auth).
- Turn on Track changes so editors can suggest edits reviewers accept or reject.
- Add inline Comments threads to content without needing real-time collaboration.
- Keep a Revision history of document changes richer than core revisions.
- Export a field's content to PDF via the export_pdf submodule + its toolbar button.
- Export content to Word (.docx) via the export_word submodule.
- Import Word documents into the editor with the import_word submodule.
- Offer an AI Assistant in the editor (OpenAI/Azure/AWS Bedrock providers) via the AI submodules.
- Let editors @-mention other users with the mentions submodule.
- Insert dynamic Merge fields / placeholders with the merge_fields submodule.
- Add Footnotes to long-form content.
- Give editors a maximise / Full-screen editing mode (free-to-use).
- Enable the Productivity pack (formatting, templates, and editing shortcuts).
- Add WProofreader spelling and grammar checking.
- Add multi-level lists, enhanced source editing, line height, or email editing via their submodules.
- Send notifications when someone mentions you, replies, or accepts/rejects a suggestion.
- Grant `use ckeditor5 access token` to roles that use cloud/on-prem features like RTC or exporters.
- Grant `use ckeditor5 exporters endpoints` to roles that use the Word/PDF export plugins.
- Enable a premium feature per text format by adding its plugin/button to that format's CKEditor 5 toolbar.
- Start from a free CKEditor premium-features trial before buying a commercial license.
- Deploy the license/Cloud Services settings as configuration between environments.
- Allow the module to alter the node form CSS so exported/collaborative documents render correctly.
- Pin the CKEditor library version used by premium features with the version_override submodule.
