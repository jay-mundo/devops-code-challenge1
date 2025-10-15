import { useEffect, useState } from "react";
import config from "./config";

function App() {
  const [message, setMessage] = useState("Loading...");

  useEffect(() => {
    fetch(`${config.backendUrl}/success`)
      .then((res) => res.json())
      .then((data) => setMessage(data.message))
      .catch((err) => {
        console.error(err);
        setMessage("Failed to fetch from backend");
      });
  }, []);

  return (
    <div>
      <h1>Frontend Fetch Example</h1>
      <p>{message}</p>
    </div>
  );
}

export default App;
