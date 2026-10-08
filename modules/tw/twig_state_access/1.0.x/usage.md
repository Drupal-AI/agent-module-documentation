<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig State Access provides Twig extensions to read Drupal state/private tempstore APIs read-only.

---

Twig State Access **exposes Drupal State and private tempstore to Twig** — read-only Twig functions to fetch
values from Drupal's State API and private temp store from within templates. It works across core 9–11.

Use it to read state/tempstore values in theming. It is a theming/developer feature, and it has a real
security caveat: **State and tempstore can contain sensitive data** — Drupal's State API is a common place for
modules to keep tokens, API keys, sync cursors and other operational secrets, and tempstore holds per-user working
data. Exposing these to Twig (even read-only) means a template author can read them and, if they render a value,
**leak it into page output**. So restrict this to **trusted template authors**, never output sensitive state/
tempstore values into public markup, and treat the ability to read arbitrary state keys in templates as
privileged. It has no access-control role. Use the Twig functions carefully.

---

- Read State/tempstore in Twig.
- Provide read-only Twig functions.
- Fetch values in templates.
- Serve theming/developers.
- Access the State API.
- Access private tempstore.
- NOTE State/tempstore can hold SENSITIVE data (tokens/keys/cursors).
- RISK leaking secrets if a template reads + renders a state value.
- Restrict to trusted template authors + never output sensitive values publicly.
- Treat reading arbitrary state keys in templates as privileged.
- Have no access-control role.
- Use the Twig functions carefully.
- Handle state access.
- Read state.
- Configure nothing (Twig).
- Fetch state.
- Handle the templates.
- Access tempstore.
- Protect the secrets.
- Provide Twig state access.
