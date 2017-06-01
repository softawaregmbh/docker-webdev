const Koa = require('koa');
const app = new Koa();

app.use(ctx => {
  ctx.body = 'Hello World from koa inside softaware/webdev';
});

app.listen(3000);