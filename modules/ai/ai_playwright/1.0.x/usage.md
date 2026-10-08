AI Playwright is an AI Agent tool that opens a page of your site in a real headless browser (Playwright / Chromium) and returns a screenshot, page title, visible text and console errors, so the Drupal Canvas AI assistant can see and verify what it builds.

---

AI Playwright gives Drupal AI Agents eyes on a live, rendered page. Its single function-call tool, Browser preview (Playwright), drives a bundled Node + Playwright script to a page on this site, captures a full-page screenshot (saved as a managed file whose id the agent can pass to describe_image to "see" it), and returns the page title, the visible text and any browser console errors. By default it only opens paths on this site, resolved against a configured internal base URL (typically the local loopback); an administrator can opt into opening absolute off-site http(s) URLs. When the capture is authenticated the runner generates a one-time auto-login link for the acting user, so the browser sees exactly what that user would. The PlaywrightRunner service shells out via Symfony Process with an argv array (never an interpolated shell command), and the tool is gated on a restricted permission. A settings page configures the internal base URL, the Node binary, the timeout, the screenshot stream wrapper and the off-site toggle. Node.js 18+ with Playwright and Chromium must be installed on the server.

---

- Let a Drupal AI Agent "see" a page it just built and verify the result instead of building blind.
- Capture a full-page screenshot of any path on the site and return it as a managed file id.
- Feed the screenshot file id to the AI's describe_image / vision tool for visual review.
- Return the rendered page title and visible text (trimmed to ~4000 chars) to the agent.
- Surface browser console errors so the agent can spot broken JS or failed asset loads.
- Preview the front page by leaving the URL empty, or a specific path like "/" or "/about".
- Capture pages as the acting user via a one-time auto-login link (see authenticated content).
- Keep captures on this site only (the safe default), resolving relative paths against the internal base URL.
- Optionally allow absolute off-site http(s) URLs when an administrator enables it.
- Point the internal base URL at the local loopback (e.g. http://localhost or http://127.0.0.1:8080) to avoid external DNS/TLS/routing.
- Pin an absolute Node.js binary path when the web server has no PATH to node.
- Cap how long a single capture may run with a configurable timeout (5-300s, default 90).
- Write screenshots to a configurable stream wrapper (public by default).
- Test the browser capture from the settings page with one click on the saved settings.
- Get a status-report warning when Node.js is not reachable on the server.
- Verify a Canvas AI build renders correctly (layout, headings, images) before finalizing it.
- Iterate on a design: build, screenshot, describe, refine - all inside one agent conversation.
- Restrict browser access to trusted roles with the dedicated "use ai playwright" permission.
- Use it alongside AI Penpot / AI Figma so the agent can both read a design and see its own output.
