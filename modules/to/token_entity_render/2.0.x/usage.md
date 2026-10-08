<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Token Entity Render provides tokens that render a whole entity in a specified view mode, rather than substituting a single field's value.

---

Drupal's built-in tokens are field-level — `[node:title]`, `[node:field_summary]`, `[user:mail]` — which covers most of what a token is for but leaves a gap wherever the requirement is *put the rendered thing here*: an email that should contain the article exactly as it appears on the site, a scheduled digest listing several nodes, a PDF template, a block whose body embeds a rendered teaser. Doing that by hand means loading the entity, fetching its view builder, rendering it in the right view mode and injecting the markup into a place that expected a string; this module packages precisely that into a token. It registers one token per entity view mode, shaped `[entity_type:render:view_mode]` (for example `[node:render:teaser]` or `[user:render:full]`), and wherever that token is replaced against an entity in context it substitutes the entity rendered in that view mode. The rendered entity is always the one already in the token's context, and the view-mode name is the only thing the token string carries — it cannot point at some other entity id. Version **2.0.0**, core `^9 || ^10 || ^11`, in the Token package, with no configuration of its own. One practical note: the replacement is a finished HTML string produced by rendering in isolation, so it carries none of the render array's cache metadata back to the surrounding email or page — where that container is cached, attach the entity's cache tags yourself so it refreshes when the entity changes.

---

- Include a rendered node in an email.
- Build a digest of several articles.
- Render a teaser inside a block.
- Embed an entity in a PDF template.
- Render an entity in a chosen view mode.
- Include full content in a notification.
- Build a rendered email newsletter.
- Embed a rendered entity in a message.
- Render a product into a confirmation.
- Include an event's details in a reminder.
- Render a profile into a directory export.
- Embed a rendered entity in a metatag.
- Build a rendered summary block.
- Include a rendered card in a template.
- Render referenced entities inline.
- Build a rendered digest for subscribers.
- Embed content in a scheduled message.
- Render an entity for an external consumer.
