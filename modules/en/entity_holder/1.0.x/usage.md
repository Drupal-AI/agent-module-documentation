<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Holder provides "holder" config entities that give a content entity a persistent identity and route across environments, even before the content exists in each one.
---
Each holder records a target entity type/bundle and the UUID of a held content entity, plus a path, title and optional fallback content. An admin can create the held entity from the holder (`/create-entity/{uuid}`) or bind an existing one (`/hold-entity/{uuid}`); once held, the holder's view route issues an internal sub-request to the held entity's canonical URL and returns its rendered output, otherwise it shows the configured fallback text (or 404). Because holders are configuration, they deploy with config sync while the actual content is created per environment and matched by UUID — solving the problem of a menu link, block, or path that must always resolve even where the content has not yet been authored.

All management routes are admin routes gated by the `administer entity holders` permission. View access on a holder defers to the held entity's own access (and is denied for disabled holders); with no held entity it falls back to `access content`. The fallback body is a formatted text field rendered through `processed_text`, so its text format governs allowed markup.
---
- Reserve a stable path for content that varies per environment
- Deploy a page placeholder via config, fill content per-site
- Bind an existing node/entity to a holder by UUID
- Create the held entity directly from the holder admin screen
- Show fallback text until the real content is authored
- Keep menu links pointing at a holder that always resolves
- Match content across dev/stage/prod by UUID
- Give a landing page a fixed URL independent of node ID
- Return 404 cleanly when neither content nor fallback exists
- Rely on the held entity's access rules for holder view access
- Disable a holder to forbid its view route
- List and manage all holders at /admin/structure/entity-holder
- Set a per-holder title shown when content is missing
- Render the held entity in place via an internal sub-request
- Use holders for reusable structural pages in a distribution
- Attach cache metadata from the held entity to the holder response
- Restrict a holder to a specific entity type and bundle
