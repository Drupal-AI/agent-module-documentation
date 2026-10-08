# NeutrinoAPI — manual setup guide

**NeutrinoAPI** (`neutrino_api`) provides a Drupal **service wrapper** around
[NeutrinoAPI](https://www.neutrinoapi.com/), a collection of general-purpose data
and analysis APIs that solve common development problems — validating email
addresses, looking up IP address information, parsing user agents, and more. The
core module gives you a ready-to-use Drupal service that encourages secure
configuration of your API credentials, and a set of opinionated submodules layer
specific features on top.

Three submodules ship with it:

- **Email Validator** (`neutrino_api_email_validator`) decorates Drupal's existing
  email-validator service through NeutrinoAPI's Email Validate API, and exposes an
  extended interface with extra data points useful for error messaging and custom
  validation logic.
- **IP Info** (`neutrino_api_ip_info`) provides IP address lookups.
- **User Agent** (`neutrino_api_ua`) provides user-agent parsing.

A few important points. NeutrinoAPI is a **paid third-party service** and requires a
non-free subscription; the module is not affiliated with Neutrino. It calls the
service over the network using **API credentials** that must be stored as secrets —
the **Key** module is strongly recommended for this. And the data you look up —
**email addresses, IP addresses, and user agents** — is sent to NeutrinoAPI, which
is a data-egress and privacy consideration you should confirm is acceptable and
disclose where required. The module runs on Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — enter your NeutrinoAPI credentials,
   stored securely.

## Where it lives in the admin menu

The module's value is its Drupal service, which other code (and its submodules)
call. Its API credentials are administered through the module's settings — enter
them there, ideally via the Key module, before any lookups will work.
