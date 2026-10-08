# Configure Friendly Captcha

Friendly Captcha is an **add-on for the CAPTCHA module** — it depends on `captcha:captcha` and
registers a challenge type via `hook_captcha()`. It is not a standalone form element. Enable
both `captcha` and `friendlycaptcha`.

## The proof-of-work approach (no user puzzle)

The `friendly-challenge` JS widget (a `<div class="frc-captcha" data-sitekey=… data-lang=…
data-puzzle-endpoint=…>`) fetches a puzzle and solves it with CPU **proof-of-work** in the
background — the visitor never clicks or reads anything. The solved token is posted in the
hidden `frc-captcha-solution` request field, and the module's `friendlycaptcha_captcha_validation`
callback verifies it server-side on submit. The challenge is marked **cacheable** (it does not
depend on session/solution state) so it works on cached pages. If keys are unset, the module
falls back to CAPTCHA's **Math** challenge and warns admins.

### Front-end library (required)

The `friendly-challenge` widget is **not** shipped/required via Composer. Install it into
`/libraries/friendly-challenge/widget.min.js` — by download, `composer require
npm-asset/friendly-challenge`, or NPM. A `hook_requirements()` warning fires at
`/admin/reports/status` if it is missing.

## Settings form

Route `friendlycaptcha.admin_settings_form` → `/admin/config/people/captcha/friendlycaptcha`
(a tab under CAPTCHA settings). Gated by CAPTCHA's **`administer CAPTCHA settings`** permission
(this module defines no permissions of its own; an old `administer friendlycaptcha` permission
was removed in update 8102). Stored in config object `friendlycaptcha.settings`:

| Key | Default | Meaning |
|---|---|---|
| `api_endpoint` | `global` | Which endpoint verifies solutions (see below) |
| `site_key` | `''` | Site key from your Friendly Captcha account (required unless `local`) |
| `api_key` | `''` | API/secret key from your account (required unless `local`) |
| `enable_validation_logging` | `false` | Log failed validations to the `friendlycaptcha` channel for debugging |

Get keys by registering at `https://app.friendlycaptcha.com/account`. Set via drush, e.g.
`drush cset friendlycaptcha.settings site_key <key>`. Config exports/deploys with
`drush config:export`.

## API endpoints (`api_endpoint`)

| Value | Behavior |
|---|---|
| `global` | Verifies against `https://api.friendlycaptcha.com/api/v1/siteverify` (site key + API key). Default. |
| `eu` | EU verification endpoint (`eu-api.friendlycaptcha.eu`). Requires a Business/Enterprise plan. |
| `eu_fallback` | EU endpoint, falling back to the Global endpoint if unavailable. Business/Enterprise plan. |
| `local` | **Self-hosted**: this Drupal site serves puzzles at `/api/v1/puzzle` (`PuzzleController`) and verifies solutions locally via the `friendlycaptcha.siteverify` service. No account, site key, or API key needed (dummy key values are auto-filled). |

## Local (self-hosted) verification — `friendlycaptcha.siteverify`

Service `friendlycaptcha.siteverify` (`Drupal\friendlycaptcha\SiteVerify`) implements the
server side of the proof-of-work in PHP: `verify($solution)` splits the token, checks the HMAC
signature against `site_key`, rejects replays via the expirable key-value store, enforces the
puzzle timeout, and validates each proof solution against the Blake2b difficulty target. It
returns `['success' => bool, 'error_id' => …, 'error' => …]`. `PuzzleController::execute()`
issues puzzles and **scales difficulty** by per-IP request frequency (`SiteVerify::SCALING`),
anonymizing the client IP. No external service is contacted in `local` mode.

## Placing the challenge

Use the CAPTCHA module UI at `/admin/config/people/captcha` to select "friendlycaptcha" as the
default challenge, or add a CAPTCHA point for a specific form id. This module only supplies the
challenge type; per-form placement is CAPTCHA's job.

## Privacy / GDPR angle

Friendly Captcha runs no user tracking and shows no interactive puzzle, making it a common
privacy/GDPR-conscious replacement for reCAPTCHA. The `local` endpoint keeps all puzzle and
verification traffic on your own server (with IP anonymization) so no data leaves the site.
