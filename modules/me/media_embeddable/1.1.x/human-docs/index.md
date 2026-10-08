# Media: Embeddable — manual setup guide

**Media: Embeddable** (`media_embeddable`) adds a media type whose source is a
block of HTML, so a third‑party embed becomes a reusable **media entity** rather
than a snippet buried in body text. Editors are handed embed codes constantly — a
video from a platform core's oEmbed doesn't cover, a map, a survey form, a
booking widget, a data visualisation. Pasting that HTML straight into a body
field means the markup can't be reused, can't be found again, and can't be
updated in one place when the provider changes their code.

Turning the embed into a media entity fixes all three problems at once: it lives
in the media library, it can be referenced from fields, it has a name and is
searchable, and updating it updates every page that uses it. The module needs
only Drupal core's Media module and works on Drupal 10 and 11.

There is one thing to treat as the module's defining characteristic rather than a
footnote: **a stored, reusable block of arbitrary HTML is a stored, reusable
block of arbitrary JavaScript.** Whoever can create these media entities can run
code in the browser of every visitor to every page that references them, and it
does not pass through a text format's filtering the way pasted markup would. Two
practical rules follow. Keep creation of this media type to the same people you
would trust to deploy code — the module ships an `administer media embeddable`
permission that is deliberately marked "restrict access." And remember that a
third‑party embed is a consent question: the provider's script sees every
visitor, so it belongs behind your consent manager exactly as an analytics tag
does.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media module.
2. [Configuration](configuration/index.md) — the module's settings form and, most
   importantly, locking down who may create embeddable media.

## Where it lives in the admin menu

The module's settings form sits under **Configuration → Media** — the
`media_embeddable.settings` route (the project documents it at
`/admin/config/media_embeddable`). The **Embeddable** media type it provides
appears under **Structure → Media types** (`/admin/structure/media`), and
individual embeds are created and managed from **Content → Media**
(`/admin/content/media`) or through the Media Library.

## How to use it

1. After enabling the module, add an **Embeddable** media item from **Content →
   Media → Add media**, or open the Media Library from a media reference field.
2. Paste the third‑party embed HTML into the source field, give the item a clear
   name so you can find it later, and save.
3. Reference the saved item from any media reference field, or insert it through
   the Media Library button in a text format that allows it. Because it is a
   single media entity, replacing an expired provider snippet in one place
   updates every page that embeds it.

> **Restrict creation.** Before editors touch this, go to **People → Permissions**
> (`/admin/people/permissions`) and grant `administer media embeddable` only to
> the small set of people you trust to deploy code. See
> [Configuration](configuration/index.md) for the reasoning.
