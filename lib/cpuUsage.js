const si = require('systeminformation');

si.currentLoad()
  .then(data => console.log(data))
  .catch(error => console.error(error));
