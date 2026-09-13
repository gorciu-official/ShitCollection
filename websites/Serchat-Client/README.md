# Gorciu's Serchat Client

A kinda optimized for mobile devices Serchat client. Much better than the original one though.

Currently is missing some features (including a separate page to log in, ability to react, reply to messages, etc) but I will be working on implementing them.

Meow.

## FAQ

> Q: why Makefile
>
> A: it's gud for aliases lol.

> Q: why node.js
>
> A: good javascript runtimes unfortuneally don't work under musl and i work on a musl linux distribution, so i'm forced to use this piece of shit

> Q: how to start this shit
>
> A: open two terminals, in the first one type: `make frontend` and `tsc --watch` in the second one (it is not required, but if you want to change something in `src/` it is a nice convienience feature); congratultions you have a dev server on 127.0.0.1:5173

> Q: can i test this without serving an HTTP server?
>
> A: no because CORS.

> Q: how to make a mobile app
>
> A: currently it works only in the browser but there will be some shit to run this or smth

> Q: is this vibecoded?
>
> A: there used to be a proxy that was vibecoded, but now there is no proxy, so this repo is 100% hand-made (not sure about changes from potential contributors tho)