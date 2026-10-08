# Configuration

BotBuster is configured from its own settings form (the `botbuster.settings`
route) under **Configuration**.

## Open the settings form

Log in as an administrator and open the **BotBuster** settings form under
**Configuration**.

## Choose the protected paths

The main setting is the list of **paths to protect**. A request to a protected
path must pass the JavaScript challenge before the page is served. Point this at
the paths that are sensitive or abuse-prone rather than the whole site:

- forms that attract spam or automated submissions;
- expensive or resource-heavy endpoints;
- any path where you have seen automated abuse.

Protecting only what needs it keeps the challenge from getting in the way of
ordinary browsing and limits the impact on no-JS clients.

## Understand the trade-offs before you rely on it

- The challenge stops **simple bots that do not run JavaScript**. It does **not**
  stop headless browsers or determined attackers that can run JS.
- Because it **requires JavaScript**, a legitimate visitor with JS disabled will
  be affected — an accessibility consideration when choosing which paths to
  protect.
- Use BotBuster as **one layer**. Pair it with rate-limiting or a CAPTCHA where
  you need stronger protection.

## Save and verify

Save the form, then visit a protected path as a normal visitor with JavaScript
enabled — you should pass the challenge and reach the page. Test with JavaScript
disabled to see exactly how a no-JS client is treated, so you know what real
users in that situation will experience.
