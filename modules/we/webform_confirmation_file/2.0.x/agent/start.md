<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Confirmation File — agent index

Webform **handler streaming a configured file to the user after completing a webform** ("fill form to
download" — whitepaper/coupon/resource). Depends on `webform`. Version **2.0.0**. Core `^10.2||^11`.

**Security:** the streamed file is **admin-configured** (not user-controlled) — but form completion is the
*only* gate, so a **public form = a public file** to anyone who submits. Confirm file + form-access align.
No access role beyond the completion gate.
