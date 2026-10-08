<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ATK helper commands (Cypress & Playwright)

These run in the **test runner** (Node), not in Drupal. The Cypress versions live in
`cypress/support/atk_commands.js` + `atk_utilities.js`; equivalent Playwright versions are in
`playwright/support/`. They read config from a project-root `cypress.atk.config.js` /
`playwright.atk.config.js` and fixtures from `data/`.

## How Drush is executed — `execDrush(cmd, args=[], options=[])`
Central helper (`atk_commands.js`). Builds `"<drushAlias> <cmd> <args> <options>"` and runs it,
choosing the transport from config:
- **Local:** `cy.exec(command)` using `atkConfig.drushCmd` (e.g. `"ddev drush"`, `"lando drush"`).
- **Custom remote:** `atkConfig.targetSite.isTarget` → `execViaSsh()` (`ssh -T … '<cmd>'`).
- **Pantheon:** `atkConfig.pantheon.isTarget` → `execPantheonDrush()` asks Terminus
  (`terminus connection:info … --format=json`) for the SFTP endpoint, then tunnels via SSH.

Everything below is a thin wrapper over `execDrush`, so all state changes happen through Drush on
whatever target the config points at.

## User lifecycle
- `createUserWithUserObject(user, roles=[], args=[], options=[])` — `drush user:create '<name>'
  --mail=<email> --password=<pass>`, then `drush user:role:add` for each role in the object /
  `roles`. `user` shape is in `data/qaUsers.json` / `data/testUser.json`.
- `deleteUserWithEmail(email)` / `deleteUserWithUid(uid)` / `deleteUserWithUserName(name)` —
  wrap `drush user:cancel -y … --delete-content`.

## Login / logout
- `logInViaForm(account)` — visits `atkConfig.logInUrl`, types `#edit-name` / `#edit-pass`
  (password typed with `{log:false}`), submits. Uses `cy.session()` for caching. Docs recommend
  using this once then switching to the faster ULI path.
- `logInViaUli(uid=1)` — `drush user:login --uid=<uid> --uri=<baseUrl>`, then visits the returned
  one-time-login URL. Fast, no form.
- `logOutViaUi()` — visits `atkConfig.logOutUrl`, confirms if a confirm page appears.

## Content
- `deleteNodeWithNid(nid)` — `drush entity:delete node <nid>`.
- `deleteNodeViaUiWithNid(nid)` — visits `atkConfig.nodeDeleteUrl` (`{nid}` substituted), submits
  the delete confirm form, asserts the "has been deleted." status message.
- `getNid()` — parses `node-nid-<n>` from the `<body>` class (set by
  `automated_testing_kit_preprocess_html`).
- `getMid()` (prevSubject) — reads `data-media-id` (set by `automated_testing_kit_preprocess_image`).
- `inputCKEditor(text)`, `save()`, `getByLabel(label)`, `getIframeBodyWithId()` — UI helpers.

## Lookups & configuration
- `getUidWithEmail(email)` / `getUsernameWithEmail(email)` — `drush user:info --mail=<email>
  --format=json`, parse the first record.
- `getDrupalConfiguration(objectName, key)` — `drush cget <object> <key> --format=json`.
- `setDrupalConfiguration(objectName, key, value)` — `drush cset -y --input-format=yaml …`.

## Email assertions — `expectEmail(mailto, subject)`
Reads `atkConfig.email.provider`:
- `mailpit` — GETs `{baseURL}/api/v1/messages` and matches To/Subject.
- `testmail` — GETs `https://api.testmail.app/api/json?apikey=…&namespace=…` and matches.
- otherwise skipped with a log message.

## Utilities (`atk_utilities.js`)
- `createRandomString(length)`, `createRandomUser()` (random name/email/password),
  `readYAML(filename)` (reads `cypress/data/<file>`), `getProperty(object, "a.b.c")`.

## Logging
`Cypress.env('atkLogLevel')` → `INFO(0) | DEBUG(1) | TRACE(2)`; `debugLog()` and `trace()` emit
only at/above their level.

Adapt `getDrushAlias()` and the `atkConfig.*` blocks to your environment; the specs under
`e2e/**` are examples to copy and modify, not a fixed suite.
