import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
ReactDOM.render(<App />, document.getElementById('root'));

# frontend/src/App.js
import React from 'react';
import EmployeeList from './EmployeeList';
import EmployeeForm from './EmployeeForm';

function App() {
  return (
    <div>
      <h1>Employee Directory</h1>
      <EmployeeForm />
      <EmployeeList />
    </div>
  );
}
export default App;
