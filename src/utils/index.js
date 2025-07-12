import stringify from "json-stable-stringify";

const to = (promise) =>
  promise.then((res) => [res, null]).catch((err) => [null, err]);

const resWin = ({ res, data = null, msg = "success" }) => {
  res.set("Content-Type", "application/json");
  return res.send(
    stringify({
      code: 200,
      data,
      msg,
    }),
  );
};

const resErr = ({ res, data = null, msg = "error" }) => {
  res.set("Content-Type", "application/json");
  return res.send(
    stringify({
      code: -1,
      data,
      msg,
    }),
  );
};

export { to, resErr, resWin };
