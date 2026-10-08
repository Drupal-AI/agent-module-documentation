<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# graphql_webform_captcha submodule

Optional submodule that exposes a webform `captcha` element's **public rendering settings** so a
decoupled frontend can render the matching challenge widget itself. Depends on `graphql_webform`
and `captcha`. Provides no permissions or config of its own.

## What it adds

The base module already exposes which provider a CAPTCHA element uses
(`WebformElementCaptcha.captchaType`) and forwards a solved token back through the submit
mutation's `requestValues` argument. This submodule adds a `captchaSettings` field on
`WebformElementCaptcha` returning a `WebformCaptchaSettings` interface. Its concrete type depends
on the element's configured provider, and each type is only present in the schema when its provider
module is installed (the SDL is assembled from per-provider files; `getBaseDefinition()` returns
`null` — tolerated — when no provider is installed):

| Provider module | GraphQL type | `requestValueKey` |
| --- | --- | --- |
| `recaptcha` (v2) | `WebformCaptchaSettingsRecaptcha` | `g-recaptcha-response` |
| `recaptcha_v3` | `WebformCaptchaSettingsRecaptchaV3` | `captcha_response` |
| `turnstile` | `WebformCaptchaSettingsTurnstile` | `cf-turnstile-response` |

## The decoupled CAPTCHA loop

1. Query the form; for a CAPTCHA element read `captchaType` and `captchaSettings { ... }` (e.g. the
   site key, size, theme).
2. Frontend renders the provider's widget with those settings; user solves it; the widget yields a
   token.
3. Frontend calls `submitWebform` with a `requestValues` entry `{ name: <requestValueKey>, value:
   <token> }`.
4. `WebformSubmit` puts that value on the synthetic POST request, and the CAPTCHA element's
   server-side validator verifies the token against the provider — so **CAPTCHA is enforced on the
   API path**, not bypassed.

## Notes

- **Only public values are exposed.** Secret keys — and the Key-module entry behind Turnstile's
  site key — never leave the server. Confirmed in `WebformCaptchaSettings` producer / model classes.
- reCAPTCHA v3 is score-based: on a failing score the `recaptcha_v3` module normally swaps in a
  fallback interactive challenge, which a headless client cannot render. For decoupled forms
  configure each action with **no fallback challenge** and clear the site-wide default challenge, so
  a failed score surfaces as a plain `captcha_response` validation error instead.
- Honeypot / time-based anti-spam that works by rendering hidden fields does **not** survive a
  client that renders its own markup — CAPTCHA (this submodule) is the anti-spam control that works
  over the API.
