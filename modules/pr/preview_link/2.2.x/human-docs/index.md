# Preview Link — manual setup guide

**Preview Link** (`preview_link`) lets editors generate a unique, tokenised URL
that grants anyone — including anonymous visitors with no Drupal account —
temporary access to preview an unpublished or draft piece of content. Instead of
creating a login for a client or stakeholder, you just send them a link, and they
can see the page exactly as it will look once published.

Each preview link carries a random token, references the entity (or entities) it
unlocks, and has an expiry date, so access is naturally time-limited. Editors
create a link from a **Preview Link** tab that appears on supported content, and
they can reset the token at any moment to instantly revoke the old URL. This makes
it a natural fit for editorial and content-moderation workflows: sign-off on
drafts, client review before go-live, QA of a page's rendered output (including
Layout Builder), or a marketing preview of an unpublished campaign.

You control which entity types and bundles can have preview links, how long links
stay valid, whether one link may unlock several related entities, and when editors
see a "link created" confirmation — all from a single settings form. Access is
governed by two permissions (one to create links, one to administer the settings),
while *viewing* a previewed page needs no permission at all, since that's the whole
point. Expired links are cleaned up automatically on cron. The module stores links
as a content entity and depends on the **Dynamic Entity Reference** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Dynamic
   Entity Reference dependency) with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, the two
   permissions, and how editors generate a link.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Preview Link**
(`/admin/config/content/preview_link`). Editors create links from the **Preview
Link** tab on an individual piece of content (its URL plus
`/generate-preview-link`).

## How to use it

1. Open the settings form and **enable the entity types and bundles** that should
   support preview links (for example only Article and Page). Set the link
   lifetime and other options. See [Configuration](configuration/index.md).
2. Grant the **Generate preview links** permission to your editorial roles.
3. An editor opens an unpublished node, clicks its **Preview Link** tab, and
   generates a link — then shares that URL with a reviewer, who can open it without
   logging in.
4. To revoke access, reset the link (which changes the token) or simply let it
   expire.
