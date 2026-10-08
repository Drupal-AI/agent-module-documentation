<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatic Alternative Text fills an image field's alt text from an external vision service — Microsoft Azure Cognitive Services Computer Vision or Alttext.ai — when an editor leaves it blank, so images arrive described instead of empty.

---

Missing alt text is the most common accessibility failure on content-managed sites, and it is a workflow problem rather than a knowledge problem: an editor uploading twenty images to an article will not write twenty descriptions. Automating a first draft changes the economics. auto_alter abstracts the vision provider behind a plugin type — `AutoAlterDescribeImage`, with the interface `DescribeImageServiceInterface`, the manager service `plugin.manager.auto_alter_describe_image`, and two built-in engines (`azure_cognitive_services`, `alttext_ai`) — so providers are swappable. The active engine, endpoint and API key live in the `auto_alter.settings` config object, edited at `admin/config/media/auto_alter`; keys can be stored in plain config or, with the optional `key` module, referenced as a Key entity. Generation is opt-in: nothing happens until the `suggestion` flag is on, and only empty alt values are ever touched — on entity save (`hook_entity_presave`), when pre-filling an image widget, or on demand through a "Get suggestion" button added to the CKEditor image dialog. Files over 1 MB are downscaled through an auto-created `auto_alter_help` image style before upload. The `auto_alter_translate` submodule runs the English Azure caption through the Azure Translator API; the Alttext.ai engine can return several languages itself. Three things belong in any recommendation. Generated alt text is a draft, not a decision: vision services describe what is in a picture, while good alt text conveys why the image is there, and a decorative image should have empty alt rather than a description of it. The service is billed per image (and per extra translation language), so access to generation is a cost control. And the image — or its public URL — is sent to a third-party provider, which is a data-flow question for any site handling sensitive or unpublished imagery. Note also that the settings route's `administer Automatic Alternative Text` permission is not declared in a permissions file, so in a stock install only user 1 can reach the form until that is addressed.

---

- Generate a first-draft alt text on image upload.
- Reduce images published with no description.
- Improve accessibility on an image-heavy site.
- Give editors a starting point they can edit.
- Backfill descriptions across a media library.
- Meet an accessibility-audit requirement.
- Describe images in several languages via Alttext.ai.
- Translate Azure captions with the submodule.
- Swap vision providers without changing editor workflow.
- Add a custom provider by writing an AutoAlterDescribeImage plugin.
- Reduce the cost of accessibility remediation.
- Prompt editors with an inline suggestion in the widget.
- Add alt on demand from the CKEditor image dialog.
- Support user-generated-content sites where editors skip alt.
- Describe photographs for a news site.
- Improve image search indexing with descriptive alt.
- Add descriptions during a bulk content import.
- Fill only empty alt fields, never overwrite editor text.
- Store the API key securely via the Key module.
- Auto-populate translated alt when creating a content translation.
- Downscale large images automatically before sending them.
- Compare Azure and Alttext.ai output on the same images.
