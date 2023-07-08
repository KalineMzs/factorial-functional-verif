<h1 align="center">Verification environment using the UVM Connect library</h1>

## :memo: Description
This project utilizes the UVM Connect library to integrate a SystemC architectural module into a functional verification environment implemented in SystemVerilog, following the UVM methodology.

The design used was developed by Danilo and is available at: https://github.com/danilo-bc/factorial-and-hdl.
<div align="center">
<img src="https://raw.githubusercontent.com/KalineMzs/factorial-functional-verif/main/verification/docs/img/testbench_architecture.png" width="400px;" alt="Foto de Kaline Menezes no GitHub"/>
</div>

## :mag_right: In this project, you will find:
* Testbench code using the UVM methodology; 
* Functional coverage for validity and data signals;
* SystemC module to encapsulate the architectural model;
* Scoreboard performing a triple comparison between the SystemVerilog, SystemC, and REFMOD modules;
* Use of active and passive agents;
* Use of constraints in the sequence;
* Utilization of UVM Connect resources;
  * Converters;
  * __uvmc_tlm1__ and __uvmc_connect__ functions;
  * UVM Command API.
* Simulation results and waveform diagrams.

## :handshake: Contributors
<table>
  <tr>
    <td align="center">
      <a href="http://github.com/KalineMzs">
        <img src="https://avatars.githubusercontent.com/u/53267552?v=4" width="100px;" alt="Foto de Kaline Menezes no GitHub"/><br>
        <sub>
          <b>KalineMzs</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/danilo-bc">
        <img src="https://avatars.githubusercontent.com/u/7863971?v=4" width="100px;" alt="Foto de Danilo no GitHub"/><br>
        <sub>
          <b>Danilo</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

## :dart: Project status
![Badge Finalizado](http://img.shields.io/static/v1?label=STATUS&message=COMPLETED&color=GREEN&style=for-the-badge)
