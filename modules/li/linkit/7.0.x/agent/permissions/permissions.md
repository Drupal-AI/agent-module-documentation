# Permissions

From `linkit.permissions.yml`:

- **`administer linkit profiles`** — full access to the Linkit profile admin UI: create, edit,
  delete profiles and manage their matchers (`/admin/config/content/linkit*`). Guards every
  profile/matcher route in `linkit.routing.yml`.

Note: the autocomplete endpoint (`linkit.autocomplete`) is not gated by this permission — it
only requires a logged-in user, and result access is enforced per matcher.
