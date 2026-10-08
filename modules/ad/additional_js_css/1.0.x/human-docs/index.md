# Additional JS CSS — manual setup guide

**Additional JS CSS** (`additional_js_css`) gives an administrator two text
editors — one for **CSS**, one for **JavaScript** — where you paste custom code
that the module then loads on every page of your default theme. It's a quick way
to drop in a small design tweak, an analytics snippet, or a third-party widget
without editing your theme's files or building a whole subtheme.

Behind the scenes the module saves what you type into flat files in the public
files directory (`public://additional_js_css/style.css` and `script.js`) and
attaches them to the page head. The CSS and JavaScript are output exactly as you
enter them.

**Treat this as code-level access.** Whatever you paste runs on your visitors'
browsers, so the settings form is restricted to the **Administer site
configuration** permission — the same level of trust as someone who can already
edit theme code. It's ideal for temporary tweaks and quick experiments; for
anything permanent, prefer real, version-controlled theme assets. Note the saved
files live in the public files directory and are world-readable by design.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the CSS and JavaScript editors, and
   how the code gets loaded.

## Where it lives in the admin menu

The editors sit at **Configuration → Development → Additional JS CSS**
(`/admin/config/development/additional-js-css`). You need the **Administer site
configuration** permission to open the form.
