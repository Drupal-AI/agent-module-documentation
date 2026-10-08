<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Access manages access and restriction to edit and view paragraphs, enforcing edit access in the widget and view access via the ADVA framework.

---

Paragraphs Access adds per-paragraph access control — letting you restrict who can view and edit
individual paragraphs. Edit access is enforced in the paragraph widget (it rewrites/hides the widget when
the user lacks edit access: `if (!$entity->access($operation))`), and view access is enforced through the
ADVA (Advanced Access) framework via a `ParagraphAccessConsumer` plugin. It depends on the Paragraphs
module.

Use it to make certain paragraphs visible/editable only to certain users (mixed-audience content, gated
sections within a page). Because view access is delegated to the ADVA framework, the actual enforcement
depends on ADVA's behaviour — so verify that restricted paragraphs are genuinely hidden in **all** rendering
contexts, not just the default themed page: confirm they don't leak through JSON:API/REST, Views that render
fields directly, or feeds (the usual "display vs data access" concern for entity-embedded content). Edit
restriction is handled at the widget. Test the access model against your content-delivery paths.

---

- Restrict view/edit of individual paragraphs.
- Hide paragraphs from some users.
- Enforce edit access in the widget.
- Enforce view access via the ADVA framework.
- Depend on the Paragraphs module.
- Gate sections within a page.
- Verify restricted paragraphs are hidden everywhere.
- Confirm no leak via JSON:API/REST.
- Check Views field rendering respects it.
- Mind the display-vs-data-access concern.
- Test against content-delivery paths.
- Use the ParagraphAccessConsumer plugin.
- Restrict per-paragraph edit.
- Restrict per-paragraph view.
- Handle mixed-audience content.
- Rely on ADVA for view enforcement.
- Verify the access model.
- Gate paragraph content.
- Control paragraph access.
- Test all rendering contexts.
