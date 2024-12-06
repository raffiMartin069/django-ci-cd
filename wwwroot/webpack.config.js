const path = require('path');

module.exports = {
  entry: {
    authentication: path.resolve(__dirname, 'scripts/authentication/index.js')
  },
  output: {
    path: path.resolve(__dirname, 'staticfiles/bundles'),
    filename: '[name].bundle.js',
  },
};