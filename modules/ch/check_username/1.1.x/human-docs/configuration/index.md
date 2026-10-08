# Configuration

Check Username has a single setting. Open the form at **Configuration → System →
Check Username** (`/admin/config/system/check-username`, route
`check_username.config_form`). You need the **Administer check_username
configuration** permission. The value is saved to the `check_username.configs`
configuration object.

## Delay

- **Delay** *(default 5000 ms)* — the debounce delay, in milliseconds, that the
  module waits after the visitor stops typing before it fires the AJAX availability
  check. A higher value means fewer requests (the check waits longer for typing to
  settle); a lower value gives quicker feedback but sends more requests as the user
  types. The value must be numeric and non‑zero.

## Save

Save the form. The new delay applies immediately — reload the registration form and
type a username to see the check fire after the delay you set.
