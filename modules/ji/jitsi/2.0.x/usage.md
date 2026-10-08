<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Jitsi provides Jitsi video conferencing integration.

---

Jitsi integrates **Jitsi Meet** video conferencing into Drupal — embedding Jitsi meeting rooms so users
can start/join video calls from the site. The project is `jitsi`; the module machine name is **`ek_jitsi`**
(part of the "ek" suite). It provides its own permissions, core 9.4+, in the ek package.

Use it to add Jitsi video meetings. It is a communications/integration feature. Security/privacy notes: video
calls run on a **Jitsi server** (a public meet.jit.si or your own instance) — prefer a **self-hosted/trusted**
Jitsi for sensitive meetings, and consider **room-name guessability** (Jitsi rooms are often reachable by URL;
use non-guessable room names / authentication on the Jitsi side to prevent uninvited joiners). It loads Jitsi's
external script. Its permission gates who can use it. Configure the Jitsi server and rooms.

---

- Integrate Jitsi Meet video calls.
- Embed Jitsi meeting rooms.
- Start/join calls from the site.
- Use the ek_jitsi module machine name.
- Provide its own permissions.
- Load Jitsi's external script.
- Prefer a self-hosted/trusted Jitsi.
- Consider room-name guessability.
- Use non-guessable rooms/auth on Jitsi.
- Run calls on a Jitsi server.
- Have no access-control role beyond permission.
- Configure the Jitsi server.
- Handle Jitsi video.
- Embed video calls.
- Configure rooms.
- Handle the integration.
- Add video conferencing.
- Join meetings.
- Secure the rooms.
- Provide Jitsi integration.
