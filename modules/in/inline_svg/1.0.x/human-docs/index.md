# Inline SVG — manual setup guide

**Inline SVG** (`inline_svg`) provides a custom field type — along with its widget
and formatter — for storing **raw SVG code** and rendering it **inline** in the
page. Instead of uploading an SVG as a file, an editor pastes the SVG markup into
a textarea, and the formatter drops that markup straight into the HTML. Because the
SVG becomes part of the DOM, you can style and animate it with CSS: change fill and
stroke colors, adjust dimensions, apply transforms — all per display, without
touching the original code.

That makes it a good fit for icons, logos, flags, and illustrations that need
dynamic color overrides or per‑view‑mode styling, and it avoids the extra HTTP
request a file‑based SVG would cost. You can reuse the same SVG code across many
entities and give it a different appearance in each place, and there are no image
files cluttering the filesystem or media library. An optional **Inline SVG Media**
submodule (`inline_svg_media`) integrates the field with Drupal's Media system,
adding a media source and a media‑library add form for SVG code.

> **Important security consideration.** Inlined SVG is **active markup**. An SVG
> file can carry `<script>`, event handlers, and external references, so rendering
> **untrusted** SVG inline is a cross‑site‑scripting (stored‑XSS) risk. The
> module's widget includes validation that rejects unsafe code and disallows risky
> tags, external links, and event handlers — but you should still treat the SVG
> field as trusted‑editor territory: grant it only to roles you trust, and
> sanitize any SVG that comes from an untrusted source before it goes in. The
> module has no access‑control role of its own; that is your responsibility to set
> via field and role permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the Media submodule.

This module has **no central settings form**. You set it up by adding the SVG field
to a bundle and configuring its widget and formatter on the field's **Manage form
display** and **Manage display** tabs, as described in "How to use it" below.

## Where it lives in the admin menu

Inline SVG adds no Configuration page. You work with it through the Field UI on
**Structure → Content types → *(bundle)* → Manage fields / Manage form display /
Manage display**.

## How to use it

1. Enable the module (and `inline_svg_media` if you want reusable SVG media items).
2. On the entity type you want (a content type, Paragraph, block, and so on), go to
   **Manage fields** and add a new field of the **SVG Code** type.
3. On **Manage form display**, the field uses a textarea widget where editors paste
   raw SVG code. The widget validates the input for unsafe code before it is saved.
4. On **Manage display**, choose the SVG formatter. In its settings you can
   override presentation per view mode — fill, stroke, `font-family`, height,
   width, `transform`, and so on — without altering the stored SVG. This lets the
   same SVG look one way in a teaser and another in the full view.
5. Add accessibility attributes such as `aria-label` or `role="img"` in your SVG
   markup as needed, since it renders as ordinary inline HTML.

> **Reminder:** restrict the SVG field to trusted editors — see the security
> consideration above.
