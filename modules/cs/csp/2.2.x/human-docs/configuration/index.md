# Configuration

## Open the settings form

1. Log in as a user with the **Administer CSP configuration** permission.
2. Go to **Configuration → System → Content Security Policy**, or navigate
   directly to `/admin/config/system/csp`.

Everything is stored in the `csp.settings` config object, so it exports with
`drush config:export` and deploys across environments.

## Two independent policies

The form manages two separate policies, each of which you can enable on its own:

- **Report-Only** — sent as the `Content-Security-Policy-Report-Only` header.
  Violations are **logged but not blocked**. This is where you start, so you can
  see what a policy *would* block without breaking the site.
- **Enforce** — sent as the `Content-Security-Policy` header. Violations are
  **blocked** by the browser. Switch this on once your Report-Only policy is clean.

The recommended workflow is report first, enforce second: run Report-Only,
collect violations, loosen the directives until only genuine threats would be
caught, then copy that policy into Enforce.

## Directives and source lists

Each policy is a set of **directives**, and each directive has a source list that
says where that resource type may come from. For every directive you set:

- **Base** — the baseline source: nothing, `'self'` (same origin), `'none'`, or
  any (`*`).
- **Flags** — optional extras such as `unsafe-inline` or `report-sample` (which
  includes a snippet of the offending code in reports).
- **Sources** — explicit hosts you want to allow, for example
  `https://cdn.example.com`.

The full directive set covers fetch directives (`default-src`, `child-src`,
`connect-src`, `font-src`, `frame-src`, `img-src`, `manifest-src`, `media-src`,
`object-src`, `prefetch-src`, `script-src` and its `-attr`/`-elem` variants,
`style-src` likewise, `worker-src`), document directives (`base-uri`, `sandbox`),
navigation directives (`form-action`, `frame-ancestors`), and others (`webrtc`,
`upgrade-insecure-requests`, `block-all-mixed-content`, `trusted-types`,
`require-trusted-types-for`). Boolean directives such as
`upgrade-insecure-requests` are simply switched on. Directives fall back per the
CSP spec — for example `script-src-elem` falls back to `script-src`, which falls
back to `default-src` — so you only need to set the specific ones you care about.

## Automatic library hosts

You rarely have to list every host by hand: the module inspects the asset
libraries your enabled modules and themes use and adds their required external
hosts (Google Fonts, maps, and so on) to the relevant directives automatically.
This list is rebuilt whenever you clear caches.

## Inline scripts — nonces, hashes, and Trusted Types

Rather than opening up `unsafe-inline`, the module can allow specific inline code:

- **Nonces** — a fresh cryptographic token is added to the policy and to your
  inline `<script>`/`<style>` so only your own inline code runs.
- **Hashes** — a known inline block can be allowed by its hash.
- **Trusted Types** — enable Trusted Types (and `require-trusted-types-for`) to
  harden DOM-XSS sinks.
- **upgrade-insecure-requests** — force all resource loads over HTTPS.

## Reporting handlers

Choose how violation reports are collected:

- **None** — no reporting endpoint (the default).
- **Report URI** — send reports to a custom endpoint you specify.
- **report-uri.com** — send reports to the report-uri.com service using the
  bundled handler.

Reporting is what makes the Report-Only phase useful — turn it on before you start
so you can see exactly which resources trip the policy.

## Defaults

Out of the box both policies are enabled with a safe baseline: `object-src 'none'`,
`script-src`/`style-src` set to `'self'` (Report-Only) and to a permissive value
in Enforce so you can tighten gradually, `base-uri`/`form-action`/`frame-ancestors`
`'self'`, `webrtc` blocked, and no reporting handler. Adjust from there.

## Save

Click **Save configuration**. The headers are emitted on the next response.
