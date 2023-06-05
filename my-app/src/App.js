import "./App.css";
export const ver = process.env.APP_VERSION;
function App() {
  // jeżeli adresem ip będzie http://localhost to zamień go na 192.168.0.1
  const origin = window.location.origin;
  const address = origin == "http://localhost" ? "192.168.0.1" : origin;


  return (
    <div className="App">
      <header className="App-header">
        <h1>Paweł Jabłoniec</h1>
        <p>Hostname: {window.location.hostname}</p>
        <p>Address: {address}</p>
        <p>Version: {ver}</p>
      </header>
    </div>
  );
}

export default App;