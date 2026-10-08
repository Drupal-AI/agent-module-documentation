# Configuration

Rules HTTP Client is configured per rule, inside the Rules UI — there's no global
settings form. You add its HTTP‑request action to a reaction rule and set the request
details there.

## Add the action to a rule

1. Log in as a user permitted to **administer rules**.
2. Go to **Configuration → Workflow → Rules** (`/admin/config/workflow/rules`).
3. Create a **reaction rule** (or edit an existing one) and choose the event that
   should trigger the request — for example *After saving a new content item*.
4. Under **Actions**, add the HTTP‑request action provided by this module.

## Configure the request

Fill in the action's fields to describe the request the server should make. Depending
on the release, these typically include:

- **URL** — the endpoint to call. This is the most important field, and the focus of
  the security guidance below.
- **Method / data** — the request payload where the action supports sending data (for
  example a POST body).

You can supply these values either as **fixed text** you type in, or via **data
selectors** that pull values from the event's context (the entity being saved, a
submitted field, and so on). Save the rule, then test it by performing the triggering
action and confirming the request reaches its destination.

## Harden against SSRF

Because the action makes your **server** send the request, the destination URL
deserves care:

- **Prefer static, admin‑controlled URLs.** When the URL is a fixed value an
  administrator typed in, the risk is low.
- **Be cautious with user‑derived URLs.** If the URL (or part of it) comes from
  user‑controlled data through a data selector, treat it as a
  **server‑side request forgery (SSRF)** surface — an attacker could steer the server
  toward internal services. Validate and, where possible, **allow‑list** the
  destinations the action may call.
- **Restrict who can build Rules.** Anyone with the *administer rules* permission can
  create a rule that makes the server call arbitrary URLs, so keep that permission to
  trusted administrators.
