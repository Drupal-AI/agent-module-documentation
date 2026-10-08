# Configuration

Because BAT API exposes booking data over REST, the configuration *is* the
security. Take the decisions below deliberately.

## Configure the REST resources with REST UI

You manage the exposed resources through **REST UI**, at **Configuration → Web
services → REST** (`/admin/config/services/rest`). For each BAT resource you want
to expose:

1. **Enable** only the resources you actually need — don't turn on more of the
   API surface than your front end uses.
2. Choose the **methods** (GET, POST, …) to allow. Read‑only clients need only
   GET; only enable write methods (which can change availability and events) if
   the caller genuinely must write.
3. Choose the **formats** (e.g. `json`) the resource accepts and returns.
4. Choose the **authentication providers** for the resource (see below).

## Set authentication and permissions deliberately

This is the part that matters most. Availability data drives real bookings, so an
unauthenticated or over‑permissive endpoint lets a caller read your availability —
or, if write methods are on, perturb it.

- **Require authentication** on any resource that isn't genuinely meant to be
  public. Pick an authentication provider appropriate to your callers (for
  example token/OAuth‑based auth for an app, or cookie auth for a same‑site
  front end). Avoid leaving booking endpoints open to anonymous requests.
- **Restrict the permissions** that govern who may read and, especially, who may
  write booking data. Grant write permission narrowly.
- Serve the API over **HTTPS** so tokens and booking data aren't sent in the
  clear.

## Rule of thumb

Expose the least you need: the fewest resources, the fewest methods, behind
authentication, with write access limited to the roles that truly require it.
Then test what an *anonymous* caller can reach — it should be only what you
intended to make public, and nothing that lets them read or change bookings.
