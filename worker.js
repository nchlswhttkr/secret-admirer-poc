addEventListener("fetch", (event) => {
  event.passThroughOnException();
  event.respondWith(handleRequest(event));
});

const matchingPath = /\/$/;

function handleRequest(event) {
  // if (event.request.cf.bot_management.score >= 50) {
  //   // TODO Bot management is only on Enterprise plan at the moment
  // }

  let matched = new URL(event.request.url).pathname.match(matchingPath);
  if (matched) event.waitUntil(fetch("PING_ME", { method: "POST" }));

  return fetch(event.request);
}
