function bail (error) {
  console.error(error)
  process.exit(1)
}

process.on("uncaughtException", bail)
process.on("unhandledRejection", bail)

const webpack = require("webpack")
const WebpackDevServer = require("webpack-dev-server")
const webpackConfig = require("./webpack.config.js")

const compiler = webpack(webpackConfig)

const bundler = new WebpackDevServer(
  {
    hot: true,
    historyApiFallback: true,
    proxy: {
      "/graphql": {
        target:
          "http://localhost:4185/dbs/todos/graphql",
        pathRewrite: { "^/graphql": "" },
      },
    },
    allowedHosts: "all",
  },
  compiler,
)

async function startServer () {
  console.info("Starting server...")
  await bundler.start()
  console.info("Server is listening!")
}

startServer()
