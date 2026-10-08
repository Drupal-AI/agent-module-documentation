# Configuration

Everything Crazy Egg does is controlled from one settings form.

## Open the settings form

1. Log in as a user with the **Administer Crazy Egg** permission (an administrator
   by default).
2. Go to **Configuration → System → Crazy Egg**, or navigate directly to
   `/admin/config/system/crazyegg`.

## Settings

- **Enabled** — the master on/off switch for all tracking. Turn it off to stop
  injecting the script site‑wide (handy during a migration) without uninstalling
  the module. It is on by default.
- **Account number** — your **numeric** Crazy Egg account number. This is the one
  required value: the module builds the tracking script URL from it, and nothing
  loads until a valid numeric account number is entered.
- **Script location** — where the tracking `<script>` tag is placed:
  - **Header** — loads as early as possible.
  - **Footer** — loads later, reducing render‑blocking on your pages.
- **Paths** — a list of path patterns (one per line) restricting which pages are
  tracked. You can use `*` wildcards and `<front>` for the front page. **Leave
  this empty to track the whole site**, or list specific paths such as
  `/promo/*` to track only your marketing landing pages.
- **Excluded roles** — check any roles whose users should **not** be tracked.
  Excluding administrators and editors keeps your own internal traffic out of the
  data. (You could also exclude the authenticated role to track only anonymous
  visitors.)

## How the settings work together

When a page is requested, the script is injected only if **all** of these are
true: tracking is enabled, a valid account number is set, the current path matches
your Paths list (or the list is empty), and the current user is not in an excluded
role. Combining path targeting and role exclusions lets you scope precisely where
and for whom tracking runs.

## Save

Click **Save configuration**. Because the settings are registered as a cacheable
dependency, changing them automatically invalidates cached pages, so your changes
take effect without a manual cache clear. To confirm tracking is live, load a
tracked page as a non‑excluded user and check that the Crazy Egg script is present
(and watch data begin appearing in your Crazy Egg account).
