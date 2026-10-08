# Capturing admin-UI screenshots with agent-browser

Use this only for modules that expose **forms/admin UI**. Prefer `drush`/config for
everything else — screenshots are documentation, not the setup mechanism.

## One-time setup (inside the DDEV web container)

```bash
npm i -g agent-browser
agent-browser install            # downloads Chrome for Testing
agent-browser install --with-deps  # installs the shared libs Chrome needs (libnspr4, gtk, ...)
```

## Always shoot at 1920×1080

Set the viewport to full HD **before** capturing, and take **viewport** screenshots
(no `--full`) so every image is exactly 1920×1080:

```bash
agent-browser set viewport 1920 1080
agent-browser screenshot /abs/path.png        # NOT --full → exact 1920×1080 frame
```

If a form is taller than 1080px, don't switch to `--full` (that breaks the fixed
size) — instead scroll the relevant section into view and take a second 1920×1080
shot:

```bash
agent-browser eval "document.querySelector('SELECTOR').scrollIntoView({block:'start'}); window.scrollBy(0,-90); 'ok'"
agent-browser screenshot /abs/path-part2.png
```

## Gotchas (all learned the hard way)

- **Run Chrome with no sandbox** in the container, or it exits with a namespace error:
  `export AGENT_BROWSER_CHROME_ARGS="--no-sandbox --disable-dev-shm-usage"`.
- **The viewport command is `set viewport <w> <h>`** (not `viewport <w> <h>`).
- **Browse `http://localhost`**, not the `https://…ddev.site` host URL — it returns 200
  from inside the container with no TLS/cert hassle.
- **Screenshot paths must be absolute.** The browser daemon has its own working directory,
  so a relative path saves somewhere unexpected. Pass a full `/var/www/html/...` path.
- **Flag before path:** `agent-browser screenshot --full /abs/path.png` (`--full` = full
  scroll height). `screenshot <selector> <path>` also works.
- Refs (`@eN`) are re-assigned on every `snapshot`; re-snapshot after any navigation.

## Login

```bash
agent-browser open "http://localhost/user/login"
agent-browser snapshot -i                 # find username/password/submit refs
agent-browser fill @eUSER admin
agent-browser fill @ePASS admin
agent-browser click @eSUBMIT
agent-browser wait --load networkidle
```
(Alternative: `drush uli --uri=http://localhost` gives a one-time login URL to `open`.)

## Capture a form

```bash
# NOTE: <project-root>/screenshots is OUTSIDE the repo — one level above
# agent-module-documentation/ — because screenshots are binaries we do not commit.
S=/var/www/html/screenshots/<name>/<version>
mkdir -p "$S"
agent-browser open "http://localhost/<admin/path>"
agent-browser wait --load networkidle
agent-browser screenshot --full "$S/<shot>.png"   # path MUST be absolute
```

Some fields appear only after interaction (e.g. Pathauto's token browser shows after
picking a Pattern type — `agent-browser select @eN "Content"` then re-snapshot). Screenshots
live at `<project-root>/screenshots/{name}/{version}/` (a sibling of the repo, not tracked
by git). Reference them from a solution doc — which sits **seven** levels below the project
root at `modules/{ab}/{name}/{version}/agent/{type}/` (note the two-letter `{ab}` shard) —
with `![alt](../../../../../../../screenshots/<name>/<version>/<shot>.png)` (seven `../`).
See [file-formats.md](file-formats.md#screenshotsnameversion-optional-outside-the-repo) for the
canonical rule; earlier docs used six `../`, which does not resolve under the sharded layout.

Close when done: `agent-browser close --all`.
