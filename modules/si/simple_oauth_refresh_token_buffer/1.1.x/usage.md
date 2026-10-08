<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple OAuth Refresh Token Buffer buffers token refresh responses for a set period to combat race conditions.

---

Simple OAuth Refresh Token Buffer **buffers OAuth token-refresh responses for a configurable short period**
— when a client sends the same refresh token twice in quick succession (a common race with concurrent
requests / token rotation), the module returns the same buffered response instead of failing the second call,
avoiding spurious auth failures. It depends on the Simple OAuth module, in the Authentication package.

Use it to make OAuth token refresh robust under concurrency. This is a **reliability/security-adjacent**
feature: it addresses a real race that otherwise breaks clients when refresh tokens rotate. Keep the **buffer
window short** (it's a brief tolerance window, not a way to make refresh tokens reusable long-term), so it
resolves races without meaningfully weakening single-use refresh-token semantics. It has no access-control role.
Configure the buffer period.

---

- Buffer OAuth token-refresh responses.
- Handle concurrent refresh requests.
- Avoid spurious refresh failures.
- Depend on Simple OAuth.
- Address a refresh-token race.
- Return the same buffered response.
- Keep the buffer window SHORT.
- Not make refresh tokens long-term reusable.
- Preserve single-use semantics.
- Have no access-control role.
- Configure the buffer period.
- Handle refresh buffering.
- Buffer refreshes.
- Configure the buffer.
- Handle races.
- Configure OAuth.
- Handle token refresh.
- Buffer tokens.
- Set the window.
- Provide refresh buffering.
