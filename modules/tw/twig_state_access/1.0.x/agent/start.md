<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig State Access — agent index

**Twig extensions to read Drupal State / private tempstore APIs (read-only)** from templates. Version **1.0.1**.
Core `^9||^10||^11`.

Theming/developer — **CAVEAT**: State/tempstore can hold **sensitive data** (modules store tokens/keys in State),
so exposing them to Twig risks leaking secrets into output. Restrict to **trusted template authors**; never render
sensitive state values publicly. No access role.
