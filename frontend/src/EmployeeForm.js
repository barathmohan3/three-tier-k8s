import React, { useState } from 'react';
import axios from 'axios';

function EmployeeForm() {
  const [name, setName] = useState('');
  const [department, setDepartment] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    axios.post('/api/employees', { name, department }, {
      headers: {
        Authorization: `Bearer ${localStorage.getItem('token')}`
      }
    }).then(() => {
      setName('');
      setDepartment('');
    }).catch(console.error);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input value={name} onChange={e => setName(e.target.value)} placeholder="Name" required />
      <input value={department} onChange={e => setDepartment(e.target.value)} placeholder="Department" required />
      <button type="submit">Add Employee</button>
    </form>
  );
}
export default EmployeeForm;
