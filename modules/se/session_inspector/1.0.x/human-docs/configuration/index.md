# Configuration

Session Inspector works as soon as you enable it and grant a permission — the
settings here are optional refinements to how session information is displayed and
who may see it.

## The two permissions

The most important "configuration" is the permission grant, at
**People → Permissions** (`/admin/people/permissions`):

- **inspect own users sessions** — lets a user view and terminate their *own*
  sessions via the **Sessions** tab on their profile. This is the everyday
  permission and is safe to give to authenticated users.
- **inspect other user sessions** — lets a role view the sessions of *other* users.
  This is powerful; grant it only to trusted administrators and use it sparingly.

## The settings form

The module provides a settings form under **Configuration** (route
`session_inspector.config`). It controls how each listed session is presented — for
example how the hostname/IP and the browser (user-agent) values are formatted.

Out of the box these are shown as their raw values. If you install the optional
formatter plugin modules, this form is where you choose to use them:

- With the **BrowserDetector** browser formatter installed, the raw user-agent
  string can be rendered as a readable browser and operating-system name.
- With the **Geocoder** hostname formatter installed, the hostname/IP can be
  resolved to a location.

Pick the formatters you want, then save. If you don't install those plugins, there's
nothing you need to change here — the defaults are fine.

## A note on what's exposed

The sessions list surfaces details such as the IP/hostname and browser for each of a
user's sessions. That is exactly what makes the feature useful for spotting
unfamiliar logins, but it does mean thinking about who can see it — which is why the
**inspect other user sessions** permission should be reserved for trusted roles.
