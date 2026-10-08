<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Big pipe override overrides big pipe by disabling it.

---

Big pipe override disables Drupal core's BigPipe — turning off the BigPipe streaming/placeholder
rendering, for cases where BigPipe conflicts with a front-end setup, a reverse proxy, or a decoupled/caching
layer that doesn't work well with streamed responses. It is in the Development package.

Use it where BigPipe must be disabled. It is a performance/rendering feature; disabling BigPipe changes how
pages are delivered (dynamic content renders inline rather than streamed), which can affect perceived
performance — weigh the tradeoff. It has no content or access role. Enable it to disable BigPipe.

---

- Disable core BigPipe.
- Turn off BigPipe streaming.
- Handle BigPipe conflicts.
- Serve reverse-proxy/decoupled setups.
- Render dynamic content inline.
- Override BigPipe.
- Weigh the perceived-performance tradeoff.
- Have no content/access role.
- Enable to disable BigPipe.
- Handle rendering.
- Disable streaming.
- Configure BigPipe off.
- Handle proxy setups.
- Turn off streaming.
- Disable placeholders.
- Handle BigPipe.
- Override rendering.
- Disable BigPipe rendering.
- Configure the override.
- Turn BigPipe off.
