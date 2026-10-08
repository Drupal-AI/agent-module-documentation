# URL Redirect — manual setup guide

**URL Redirect** (`url_redirect`) sends visitors to a different URL based on **who
they are** — their role or their specific user account — when they visit a
configured path. Each rule is a small config entity: you give it a source path, a
destination, and whether it applies to certain roles or certain users. When a
matching visitor hits the path, the module issues a 301 (permanent) redirect.

It is more flexible than a plain path redirect. Source paths support the `<front>`
alias for the home page and `*` wildcards (like `/reports/*`), so you can redirect
whole sections. Destinations can be internal paths, the front page, or external
URLs. A **negate** option inverts a rule so it applies to everyone *except* the
listed roles or users, and an optional status message can tell visitors they have
been redirected. Rules also run on access-denied (403) responses, so you can bounce
users away from pages they cannot reach to a friendlier destination.

The module stores each rule as a `url_redirect` config entity, managed from one
admin collection page, and ships three permissions that gate the settings, edit,
and delete screens. It has no Drush commands and no plugins.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage redirect rules,
   field by field.

## Where it lives in the admin menu

Once enabled, manage your rules at **Configuration → System → URL Redirect**
(`/admin/config/system/url_redirect`). The list page and the **Add URL Redirect**
form require the **Access URL Redirect Settings** permission; separate permissions
gate the edit and delete screens.
