# Environment Indicator Header — manual setup guide

**Environment Indicator Header** (`environment_indicator_header`) is a small
add‑on to the [Environment Indicator](https://www.drupal.org/project/environment_indicator)
module. Where Environment Indicator colours the admin toolbar so you can tell at a
glance whether you are on development, staging, or production, this module adds one
more signal: it emits the current **release string** in an **HTTP response header
named `Release`**, so the deployed release is visible to tools and requests that
never see the toolbar.

That makes it handy for developers and for automated checks — you can confirm which
release answered a request by looking at the response headers, without loading a
page as an administrator.

The value comes from the `environment_indicator.current_release` Drupal *state*
key — the same "current release" value Environment Indicator can display. You
set it per environment (typically from deployment tooling) with
`drush state:set environment_indicator.current_release <release>`. There is nothing
else to configure; when the state value is empty, no header is added.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in its Environment Indicator dependency, and enable it.

This add‑on has **no configuration page of its own**. Its only input is the
`environment_indicator.current_release` state value described above.

## Where it lives in the admin menu

Environment Indicator Header adds no admin page. Environment Indicator itself is
configured at **Configuration → Development → Environment indicator**
(`/admin/config/development/environment-indicator`), but this add‑on has no UI: once
it is enabled and the release state value is set, the release is surfaced in the
response HTTP headers with no further setup.

## How to use it

1. Install and enable **Environment Indicator** (this module pulls it in).
2. Enable this module.
3. Set the release value on each environment, for example from your deploy script:
   `drush state:set environment_indicator.current_release v1.2.44`.
4. Request any page on the site and inspect the **response headers** (for example
   with your browser's developer tools or `curl -I`). The `Release` header carries
   the value you set, confirming which release served the request.
