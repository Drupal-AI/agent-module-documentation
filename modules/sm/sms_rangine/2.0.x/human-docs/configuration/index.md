# Configuration

SMS Rangine has no settings page of its own — you configure it by adding a gateway
to the **SMS Framework**, which is where its fields appear.

## Add the gateway

1. Log in as a user who can administer SMS Framework.
2. Go to **Admin → Config → SMS → Gateways** and add a new gateway.
3. Choose the **Rangine** gateway plugin.

## Fields

The Rangine gateway stores the following settings (per gateway):

- **User** (`user`) — your Rangine panel username.
- **Password** (`pass`) — your Rangine panel password.
- **Sender** (`sender`) — the sender line/number your Rangine account sends from.
- **Confirm message** (`confirm`) — a custom confirmation message shown after a
  successful send.
- **Host** (`host`) — the Rangine API host, default `sms.rangine.ir`. **Set this
  to `https://sms.rangine.ir`.** With the bare default (no scheme) the request
  falls back to plain HTTP, and in pattern mode your username and password are
  placed in the URL query string — so using the `https://` form keeps your
  credentials from travelling in cleartext.
- **Debug** (`debug`) — when enabled, the outbound message (with sender and
  recipient) is shown on the page instead of actually being sent, which is handy
  for local development and testing.

Save the gateway, then set it as the SMS Framework **default** (or route specific
numbers to it) so your outbound SMS goes through Rangine.

## Sending plain messages

A normal send POSTs form fields (`uname`, `pass`, `from`, `to`, `message`,
`op=send`) to `{host}/services.jspd`. Just send a message to a recipient through
any SMS Framework feature and it routes through Rangine.

## Sending pattern (template) messages

Rangine's pattern feature is the fast way to send pre‑approved templates. Create a
pattern in your Rangine panel; each pattern has its own code. Then send a message
whose body uses this structure:

```
patterncode:AAAA;username:admin;password:11111
```

Start with `patterncode` (or `pcode`), a colon, then the pattern code, a
semicolon, and then each template variable as `name:value` pairs separated by
semicolons. Internally a pattern send is a GET request to
`{host}/patterns/pattern?...` — which is exactly why setting the **host** to
`https://…` matters, since those parameters include your username and password.

## Delivery status

Responses are decoded and mapped to SMS Framework delivery statuses, and Rangine's
numeric error codes are translated to human‑readable (Persian) messages so you can
tell what happened with a send.
