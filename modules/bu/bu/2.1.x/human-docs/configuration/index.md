# Configuration

Browser update ships with working defaults, so the notice behaves sensibly the moment
you enable the module. Everything below is about tuning it.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Browser update**, or navigate directly to
   `/admin/config/system/browser-update`.

The form groups its options under *Browser Versions*, *Visibility*, *Additional
Settings*, and a top-level *Test Mode* checkbox.

## Browser Versions — which browsers get nagged

For each browser you set how many versions behind counts as "outdated." The value is a
threshold: `-N` means "more than N versions behind"; `-0.01` means "every outdated
version."

- **IE/Edge** (default `-5`)
- **Firefox** (default `-4`)
- **Opera** (default `-4`)
- **Safari** (default `-2`)
- **Chrome** (default `-4`)

Plus three toggles:

- **Insecure** *(on by default)* — also notify any version with known severe security
  issues.
- **Unsupported** *(off by default)* — also notify browsers no longer supported by
  their vendor.
- **Mobile** *(on by default)* — also notify mobile browsers.

## Visibility — where the notice appears

- **Position** — where the message sits: **top** (default), **bottom**, or **corner**.
- **Visibility type** — **hide** (show everywhere *except* the listed pages, the
  default) or **show** (only on the listed pages).
- **Pages** — a newline-separated path list; `*` is a wildcard and `<front>` is the
  front page. The default is `admin/*` with type *hide*, so the notice stays off admin
  pages.
- **Test Mode** *(off by default)* — force the message on **all** pages, ignoring the
  visibility rules, while you configure it. You can also preview on any single page by
  appending `#test-bu` to its URL.

## Additional Settings — appearance and behaviour

- **New window** *(on by default)* — open the update link in a new window.
- **No close** *(off by default)* — hide the "Ignore" button so the reminder is harder
  to dismiss.
- **Reminder** — hours before the message reappears (0 = always show).
- **Reminder (closed)** — hours before it reappears after the user closes it.
- **Text override** — a custom message template. Use the placeholders `{brow_name}`,
  `{up_but}`, and `{ignore_but}`.
- **URL** — a custom destination the user is sent to when they click the notification.
- **Source** — override the base script URL. Left empty, it defaults to
  `//browser-update.org/update.min.js`. Point this (and **Show source**, default
  `//browser-update.org/update.show.min.js`) at a self-hosted or CDN copy if you'd
  rather not call browser-update.org directly.

Click **Save configuration** to apply.

## Setting values without the UI

The module provides no Drush commands of its own, but you can set any key with core
config commands, e.g.:

```bash
ddev drush config:set bu.settings position bottom -y
```
