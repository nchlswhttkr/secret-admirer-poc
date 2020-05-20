# secret-admirer-poc

Originally I was going to build a service to notify me when a sufficiently human user visits my site.

Cloudflare is starting to provide bot management capabilities, and part of this includes exposing a `cf.bot_management.score` for how "human" an incoming request is.

I was tinkering with building a tool to notify me when a sufficiently "human" request comes into a my website, but unfortunately bot management features are currently limited to the Enterprise plan.

So I'm leaving this WIP here (not quite working, some weird behaviour on cached requests). I might come back to it later.

You'll need to have [ngrok] and [cargo] installed. It only works on macOS because it uses AppleScript snippets to show notifications.

```sh
git clone https://github.com/nchlswhttkr/secret-admirer-poc.git
cd secret-admirer-poc

cp config.sh.template config.sh
vi config.sh # set your credentials/variables

$SHELL start.sh

$SHELL stop.sh
```
