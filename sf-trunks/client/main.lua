local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
InTrunk = nil
TrunkVehicle = 0
L0_1 = GetPlayerServerId
L1_1 = PlayerId
L1_1, L2_1, L3_1, L4_1, L5_1 = L1_1()
L0_1 = L0_1(L1_1, L2_1, L3_1, L4_1, L5_1)
MyServerId = L0_1
CameraTrunkId = -99
L0_1 = {}
Offsets = L0_1
L0_1 = Citizen
L0_1 = L0_1.CreateThread
function L1_1()
  local L0_2, L1_2
  L0_2 = Citizen
  L0_2 = L0_2.Wait
  L1_2 = 5000
  L0_2(L1_2)
  L0_2 = TriggerServerEvent
  L1_2 = "sf-trunks:init"
  L0_2(L1_2)
end
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "sf-trunks:enterTrunk"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = DoesEntityExist
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = IsVehicleNpc
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L1_2 = IsVehicleOpen
      L2_2 = A0_2
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = NetworkGetNetworkIdFromEntity
        L2_2 = A0_2
        L1_2 = L1_2(L2_2)
        L2_2 = NetworkDoesNetworkIdExist
        L3_2 = L1_2
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = ProgressBar
          L3_2 = _L
          L4_2 = "getIntoTrunk"
          L3_2 = L3_2(L4_2)
          L4_2 = Config
          L4_2 = L4_2.GetIntoTrunkProgressBar
          L4_2 = L4_2.duration
          L5_2 = Config
          L5_2 = L5_2.GetIntoTrunkProgressBar
          L5_2 = L5_2.canCancel
          L2_2 = L2_2(L3_2, L4_2, L5_2)
          if L2_2 then
            L2_2 = GetInTrunk
            L3_2 = A0_2
            L4_2 = L1_2
            L2_2(L3_2, L4_2)
          end
        end
    end
  end
  else
    L1_2 = HudAddNotification
    L2_2 = _L
    L3_2 = "cannotGetIntoTrunk"
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    L1_2(L2_2, L3_2, L4_2, L5_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "sf-trunks:exitTrunk"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  if nil ~= A0_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = IsVehicleOpen
      L2_2 = A0_2
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = NetworkGetNetworkIdFromEntity
        L2_2 = A0_2
        L1_2 = L1_2(L2_2)
        L2_2 = NetworkDoesNetworkIdExist
        L3_2 = L1_2
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = CheckVehicleSpeed
          L3_2 = A0_2
          L2_2 = L2_2(L3_2)
          if L2_2 then
            L2_2 = CanExitVehicleTrunk
            L3_2 = A0_2
            L2_2 = L2_2(L3_2)
            if L2_2 then
              L2_2 = ProgressBar
              L3_2 = _L
              L4_2 = "getOutOfTrunk"
              L3_2 = L3_2(L4_2)
              L4_2 = Config
              L4_2 = L4_2.ExitTrunkProgressBar
              L4_2 = L4_2.duration
              L5_2 = Config
              L5_2 = L5_2.ExitTrunkProgressBar
              L5_2 = L5_2.canCancel
              L2_2 = L2_2(L3_2, L4_2, L5_2)
              if L2_2 then
                L2_2 = GetOutTrunk
                L3_2 = A0_2
                L4_2 = L1_2
                L2_2(L3_2, L4_2)
              end
          end
          else
            L2_2 = HudAddNotification
            L3_2 = _L
            L4_2 = "vehicleIsTooFast"
            L3_2, L4_2, L5_2 = L3_2(L4_2)
            L2_2(L3_2, L4_2, L5_2)
          end
        end
      end
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "sf-trunks:putInClosest"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = GetEntityType
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 2 == L1_2 then
    L1_2 = PlayerPedId
    L1_2 = L1_2()
    L2_2 = GetClosestPlayer
    L2_2, L3_2 = L2_2()
    if L3_2 then
      L4_2 = DoesEntityExist
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      if L4_2 and L3_2 ~= L1_2 then
        A0_2 = L3_2
    end
    else
      return
    end
  end
  L1_2 = NetworkGetPlayerIndexFromPed
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if -1 ~= L1_2 then
    L2_2 = GetPlayerServerId
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = Player
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L3_2 = L3_2.state
    if L3_2 then
      L4_2 = L3_2.SFTRUNKS_DEAD
      if not L4_2 then
        L4_2 = L3_2.SFTRUNKS_HANDCUFFED
        if not L4_2 then
          goto lbl_104
        end
      end
      L4_2 = GetClosestVehicle_T
      L4_2 = L4_2()
      if nil ~= L4_2 then
        L5_2 = DoesEntityExist
        L6_2 = L4_2
        L5_2 = L5_2(L6_2)
        if L5_2 then
          L5_2 = GetVehicleDoorLockStatus
          L6_2 = L4_2
          L5_2 = L5_2(L6_2)
          if 2 == L5_2 then
            L5_2 = HudAddNotification
            L6_2 = _L
            L7_2 = "vehicleIsLocked"
            L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
            L5_2(L6_2, L7_2, L8_2, L9_2)
            return
          end
          L5_2 = IsVehicleNpc
          L6_2 = L4_2
          L5_2 = L5_2(L6_2)
          if not L5_2 then
            L5_2 = IsVehicleOpen
            L6_2 = L4_2
            L5_2 = L5_2(L6_2)
            if L5_2 then
              L5_2 = ProgressBar
              L6_2 = _L
              L7_2 = "puttingPlayerIntoTrunk"
              L6_2 = L6_2(L7_2)
              L7_2 = Config
              L7_2 = L7_2.PutPlayerIntoTrunkProgressBar
              L7_2 = L7_2.duration
              L8_2 = Config
              L8_2 = L8_2.PutPlayerIntoTrunkProgressBar
              L8_2 = L8_2.canCancel
              L5_2 = L5_2(L6_2, L7_2, L8_2)
              if L5_2 then
                L5_2 = NetworkGetNetworkIdFromEntity
                L6_2 = L4_2
                L5_2 = L5_2(L6_2)
                L6_2 = NetworkDoesNetworkIdExist
                L7_2 = L5_2
                L6_2 = L6_2(L7_2)
                if L6_2 then
                  L6_2 = TriggerServerEvent
                  L7_2 = "sf-trunks:putInClosest"
                  L8_2 = L2_2
                  L9_2 = L5_2
                  L6_2(L7_2, L8_2, L9_2)
                end
              end
          end
          else
            L5_2 = HudAddNotification
            L6_2 = _L
            L7_2 = "cantPutPlayerIntoThatVehicle"
            L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
            L5_2(L6_2, L7_2, L8_2, L9_2)
          end
        end
      end
    end
  end
  ::lbl_104::
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "sf-trunks:takeOutPlayer"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = IsVehicleOpen
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = HudAddNotification
    L2_2 = _L
    L3_2 = "vehicleIsLocked"
    L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2(L3_2)
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    return
  end
  L1_2 = Entity
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L1_2 = L1_2.state
  L2_2 = L1_2.Trunk
  if nil ~= L2_2 then
    L2_2 = NetworkGetNetworkIdFromEntity
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = ProgressBar
    L4_2 = _L
    L5_2 = "pullingPlayerOutOfTrunk"
    L4_2 = L4_2(L5_2)
    L5_2 = Config
    L5_2 = L5_2.GetPlayerOutOfTrunkProgressBar
    L5_2 = L5_2.duration
    L6_2 = Config
    L6_2 = L6_2.GetPlayerOutOfTrunkProgressBar
    L6_2 = L6_2.canCancel
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if L3_2 then
      L3_2 = NetworkDoesNetworkIdExist
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = IsVehicleOpen
        L4_2 = A0_2
        L3_2 = L3_2(L4_2)
        if L3_2 then
          L3_2 = TriggerServerEvent
          L4_2 = "sf-trunks:takeOutPlayer"
          L5_2 = L2_2
          L3_2(L4_2, L5_2)
        end
      end
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "sf-trunks:getIn"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = NetworkGetEntityFromNetworkId
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = DoesEntityExist
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = GetInTrunk
    L3_2 = L1_2
    L4_2 = A0_2
    L2_2(L3_2, L4_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "sf-trunks:getOut"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = NetworkGetEntityFromNetworkId
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = DoesEntityExist
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = GetOutTrunk
    L3_2 = L1_2
    L4_2 = A0_2
    L2_2(L3_2, L4_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "sf-trunks:getOffsets"
function L2_1(A0_2)
  local L1_2
  Offsets = A0_2
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "sf-trunks:setNewOffset"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  L3_2 = Offsets
  L4_2 = {}
  L4_2.o = A1_2
  L4_2.r = A2_2
  L3_2[A0_2] = L4_2
end
L0_1(L1_1, L2_1)
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = GetOffsetFromEntityInWorldCoords
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = 0.0
  L5_2 = 1.0
  L6_2 = 0.0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = nil
  L4_2 = nil
  L5_2 = nil
  L6_2 = GetGamePool
  L7_2 = "CVehicle"
  L6_2 = L6_2(L7_2)
  L7_2 = 1
  L8_2 = #L6_2
  L9_2 = 1
  for L10_2 = L7_2, L8_2, L9_2 do
    L11_2 = Offsets
    L12_2 = GetEntityModel
    L13_2 = L6_2[L10_2]
    L12_2 = L12_2(L13_2)
    L11_2 = L11_2[L12_2]
    if nil ~= L11_2 or false == A0_2 then
      L11_2 = GetEntityCoords
      L12_2 = L6_2[L10_2]
      L11_2 = L11_2(L12_2)
      L11_2 = L2_2 - L11_2
      L11_2 = #L11_2
      if nil == A1_2 then
        L12_2 = L3_2 or L12_2
        if not L3_2 then
          L12_2 = 5
        end
        if L11_2 < L12_2 then
          L3_2 = L11_2
          L5_2 = L6_2[L10_2]
        end
      elseif A1_2 > L11_2 then
        L3_2 = L11_2
        L5_2 = L6_2[L10_2]
      end
    end
  end
  return L5_2
end
GetClosestVehicle_T = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = PlayerPedId
  L0_2 = L0_2()
  L1_2 = GetActivePlayers
  L1_2 = L1_2()
  L2_2 = GetOffsetFromEntityInWorldCoords
  L3_2 = L0_2
  L4_2 = 0.0
  L5_2 = 1.0
  L6_2 = 0.0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = nil
  L4_2 = nil
  L5_2 = nil
  L6_2 = PlayerId
  L6_2 = L6_2()
  L7_2 = 1
  L8_2 = #L1_2
  L9_2 = 1
  for L10_2 = L7_2, L8_2, L9_2 do
    L11_2 = L1_2[L10_2]
    if L11_2 ~= L6_2 then
      L12_2 = GetPlayerPed
      L13_2 = L11_2
      L12_2 = L12_2(L13_2)
      L13_2 = GetEntityCoords
      L14_2 = L12_2
      L13_2 = L13_2(L14_2)
      L13_2 = L2_2 - L13_2
      L13_2 = #L13_2
      L14_2 = L3_2 or L14_2
      if not L3_2 then
        L14_2 = 2
      end
      if L13_2 < L14_2 then
        L14_2 = IsPedInAnyVehicle
        L15_2 = L12_2
        L16_2 = true
        L14_2 = L14_2(L15_2, L16_2)
        if not L14_2 then
          L3_2 = L13_2
          L4_2 = L11_2
          L5_2 = L12_2
        end
      end
    end
  end
  L7_2 = GetPlayerServerId
  L8_2 = L4_2
  L7_2 = L7_2(L8_2)
  L8_2 = L5_2
  return L7_2, L8_2
end
GetClosestPlayer = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = DoesEntityExist
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = NetworkDoesNetworkIdExist
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = Entity
      L3_2 = A0_2
      L2_2 = L2_2(L3_2)
      L2_2 = L2_2.state
      if L2_2 then
        L3_2 = L2_2.Trunk
        if nil == L3_2 then
          L3_2 = SetStateInTrunk
          L4_2 = A1_2
          L5_2 = true
          L6_2 = A0_2
          L3_2(L4_2, L5_2, L6_2)
        end
      end
    end
  end
end
GetInTrunk = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = DoesEntityExist
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = NetworkDoesNetworkIdExist
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = SetStateInTrunk
      L3_2 = A1_2
      L4_2 = nil
      L5_2 = A0_2
      L2_2(L3_2, L4_2, L5_2)
    end
  end
end
GetOutTrunk = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = TriggerServerEvent
  L5_2 = "sf-trunks:inTrunk"
  L6_2 = A0_2
  L7_2 = A1_2
  L4_2(L5_2, L6_2, L7_2)
  InTrunk = A1_2
  TrunkVehicle = A2_2
  if A1_2 then
    L4_2 = LocalPlayer
    L4_2 = L4_2.state
    L5_2 = L4_2
    L4_2 = L4_2.set
    L6_2 = "InTrunk"
    L7_2 = A0_2
    L8_2 = true
    L4_2(L5_2, L6_2, L7_2, L8_2)
  else
    L4_2 = LocalPlayer
    L4_2 = L4_2.state
    L5_2 = L4_2
    L4_2 = L4_2.set
    L6_2 = "InTrunk"
    L7_2 = nil
    L8_2 = true
    L4_2(L5_2, L6_2, L7_2, L8_2)
  end
  if A1_2 then
    L4_2 = Offsets
    L5_2 = GetEntityModel
    L6_2 = A2_2
    L5_2 = L5_2(L6_2)
    L4_2 = L4_2[L5_2]
    if L4_2 then
      L5_2 = SetPedProofInTrunk
      L6_2 = L3_2
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = SetPedCanRagdoll
      L6_2 = L3_2
      L7_2 = false
      L5_2(L6_2, L7_2)
      L5_2 = SetupCameraTrunk
      L6_2 = A2_2
      L5_2(L6_2)
      L5_2 = AttachEntityToEntity
      L6_2 = L3_2
      L7_2 = A2_2
      L8_2 = 0
      L9_2 = L4_2.o
      L9_2 = L9_2.x
      L10_2 = L4_2.o
      L10_2 = L10_2.y
      L11_2 = L4_2.o
      L11_2 = L11_2.z
      L12_2 = L4_2.r
      L12_2 = L12_2.x
      L13_2 = L4_2.r
      L13_2 = L13_2.y
      L14_2 = L4_2.r
      L14_2 = L14_2.z
      L15_2 = true
      L16_2 = true
      L17_2 = false
      L18_2 = true
      L19_2 = 1
      L20_2 = true
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      L5_2 = PlayTrunkAnim
      L5_2()
    end
  else
    L4_2 = DetachPed
    L4_2()
    L4_2 = DoesEntityExist
    L5_2 = A2_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = SetPedProofInTrunk
      L5_2 = L3_2
      L6_2 = false
      L4_2(L5_2, L6_2)
      L4_2 = SetPedCanRagdoll
      L5_2 = L3_2
      L6_2 = true
      L4_2(L5_2, L6_2)
      L4_2 = GetModelDimensions
      L5_2 = GetEntityModel
      L6_2 = A2_2
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L5_2(L6_2)
      L4_2, L5_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      L6_2 = GetOffsetFromEntityInWorldCoords
      L7_2 = A2_2
      L8_2 = 0.0
      L9_2 = L4_2.y
      L9_2 = L9_2 - 1.0
      L10_2 = 0.1
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
      L7_2 = SetEntityCoords
      L8_2 = L3_2
      L9_2 = L6_2.x
      L10_2 = L6_2.y
      L11_2 = L6_2.z
      L12_2 = false
      L13_2 = false
      L14_2 = false
      L15_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      L7_2 = PlaceObjectOnGroundProperly
      L8_2 = L3_2
      L7_2(L8_2)
    end
    L4_2 = DisableCameraTrunk
    L4_2()
    TrunkVehicle = 0
  end
end
SetStateInTrunk = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L2_2 = CameraTrunkId
  if nil ~= L2_2 then
    L2_2 = DoesCamExist
    L3_2 = CameraTrunkId
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_98
    end
  end
  L2_2 = CreateCam
  L3_2 = "DEFAULT_SCRIPTED_CAMERA"
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  CameraTrunkId = L2_2
  L2_2 = TriggerEvent
  L3_2 = "sf-trunks:isUsingCamera"
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = SetCamActive
  L3_2 = CameraTrunkId
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = RenderScriptCams
  L3_2 = true
  L4_2 = true
  L5_2 = 1000
  L6_2 = true
  L7_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = GetEntityCoords
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = Config
  L4_2 = L4_2.Camera
  L4_2 = L4_2.DistanceFromCar
  if A0_2 == L2_2 then
    L4_2 = 2.0
  end
  L5_2 = 15.0
  L6_2 = GetEntityHeading
  L7_2 = TrunkVehicle
  L6_2 = L6_2(L7_2)
  L6_2 = L6_2 - 180.0
  L6_2 = -L6_2
  if nil ~= A1_2 then
    L7_2 = GetEntityHeading
    L8_2 = A1_2
    L7_2 = L7_2(L8_2)
    L7_2 = L7_2 - 180.0
    L6_2 = -L7_2
  end
  L7_2 = 0.0
  L8_2 = 0.0
  L9_2 = Config
  L9_2 = L9_2.Camera
  L9_2 = L9_2.FreeCameraSpeed
  L10_2 = 1.0
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = 0.0
  L15_2 = 0.0
  L16_2 = 0.0
  L17_2 = 0.0
  L18_2 = 0.0
  L19_2 = 0.0
  L20_2 = vec3
  L21_2 = 0.0
  L22_2 = 0.0
  L23_2 = 0.0
  L20_2 = L20_2(L21_2, L22_2, L23_2)
  L21_2 = Config
  L21_2 = L21_2.Camera
  L21_2 = L21_2.Stationary
  L22_2 = vec3
  L23_2 = 0.0
  L24_2 = 0.0
  L25_2 = 0.0
  L22_2 = L22_2(L23_2, L24_2, L25_2)
  L23_2 = GetModelDimensions
  L24_2 = GetEntityModel
  L25_2 = TrunkVehicle
  L24_2, L25_2, L26_2 = L24_2(L25_2)
  L23_2, L24_2 = L23_2(L24_2, L25_2, L26_2)
  if not L21_2 then
    L25_2 = L24_2.y
    L4_2 = L4_2 + L25_2
  end
  L25_2 = Citizen
  L25_2 = L25_2.CreateThreadNow
  function L26_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    while true do
      L0_3 = CameraTrunkId
      if nil == L0_3 then
        break
      end
      L0_3 = GetEntityCoords
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L3_2 = L0_3
      L0_3 = L21_2
      if L0_3 then
        L0_3 = GetOffsetFromEntityInWorldCoords
        L1_3 = A0_2
        L2_3 = 0.0
        L3_3 = L23_2.y
        L4_3 = L4_2
        L3_3 = L3_3 - L4_3
        L4_3 = L24_2.z
        L5_3 = Config
        L5_3 = L5_3.Camera
        L5_3 = L5_3.StationaryHeight
        L4_3 = L4_3 + L5_3
        L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
        L22_2 = L0_3
        L0_3 = SetCamCoord
        L1_3 = CameraTrunkId
        L2_3 = L22_2.x
        L3_3 = L22_2.y
        L4_3 = L22_2.z
        L0_3(L1_3, L2_3, L3_3, L4_3)
        L0_3 = PointCamAtCoord
        L1_3 = CameraTrunkId
        L2_3 = L3_2.x
        L3_3 = L3_2.y
        L4_3 = L3_2.z
        L0_3(L1_3, L2_3, L3_3, L4_3)
      else
        L0_3 = EnableControlAction
        L1_3 = 0
        L2_3 = 3
        L3_3 = true
        L0_3(L1_3, L2_3, L3_3)
        L0_3 = EnableControlAction
        L1_3 = 0
        L2_3 = 4
        L3_3 = true
        L0_3(L1_3, L2_3, L3_3)
        L0_3 = EnableControlAction
        L1_3 = 0
        L2_3 = 5
        L3_3 = true
        L0_3(L1_3, L2_3, L3_3)
        L0_3 = EnableControlAction
        L1_3 = 0
        L2_3 = 6
        L3_3 = true
        L0_3(L1_3, L2_3, L3_3)
        L0_3 = GetControlNormal
        L1_3 = 0
        L2_3 = 6
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = GetControlNormal
        L2_3 = 0
        L3_3 = 5
        L1_3 = L1_3(L2_3, L3_3)
        L2_3 = GetControlNormal
        L3_3 = 0
        L4_3 = 3
        L2_3 = L2_3(L3_3, L4_3)
        L3_3 = GetControlNormal
        L4_3 = 0
        L5_3 = 4
        L3_3 = L3_3(L4_3, L5_3)
        L17_2 = L3_3
        L16_2 = L2_3
        L15_2 = L1_3
        L14_2 = L0_3
        L0_3 = L14_2
        L1_3 = L15_2
        L0_3 = L0_3 + L1_3
        L7_2 = L0_3
        L0_3 = L16_2
        L1_3 = L17_2
        L0_3 = L0_3 + L1_3
        L8_2 = L0_3
        L0_3 = GetEntityRotation
        L1_3 = TrunkVehicle
        L2_3 = 2
        L0_3 = L0_3(L1_3, L2_3)
        L20_2 = L0_3
        L0_3 = L9_2
        L1_3 = GetFrameTime
        L1_3 = L1_3()
        L0_3 = L0_3 * L1_3
        L10_2 = L0_3
        L0_3 = IsNuiFocused
        L0_3 = L0_3()
        if not L0_3 then
          L0_3 = L5_2
          L1_3 = L8_2
          L2_3 = L10_2
          L1_3 = L1_3 * L2_3
          L0_3 = L0_3 + L1_3
          L5_2 = L0_3
          L0_3 = L6_2
          L1_3 = L7_2
          L2_3 = L10_2
          L1_3 = L1_3 * L2_3
          L0_3 = L0_3 + L1_3
          L6_2 = L0_3
        end
        L0_3 = math
        L0_3 = L0_3.max
        L1_3 = -70.0
        L2_3 = math
        L2_3 = L2_3.min
        L3_3 = 35.0
        L4_3 = L5_2
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3, L4_3)
        L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
        L5_2 = L0_3
        L0_3 = math
        L0_3 = L0_3.max
        L1_3 = -180.0
        L2_3 = math
        L2_3 = L2_3.min
        L3_3 = 180.0
        L4_3 = L6_2
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3, L4_3)
        L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
        L6_2 = L0_3
        L0_3 = L6_2
        L1_3 = 179.999
        if L0_3 > L1_3 then
          L0_3 = -179.999
          L6_2 = L0_3
        end
        L0_3 = L6_2
        L1_3 = -179.999
        if L0_3 < L1_3 then
          L0_3 = 179.999
          L6_2 = L0_3
        end
        L0_3 = L20_2.x
        if L0_3 < 0 then
          L0_3 = math
          L0_3 = L0_3.max
          L1_3 = math
          L1_3 = L1_3.abs
          L2_3 = L20_2.x
          L1_3 = L1_3(L2_3)
          L1_3 = L1_3 + 5.0
          L2_3 = math
          L2_3 = L2_3.min
          L3_3 = 35.0
          L4_3 = L5_2
          L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3, L4_3)
          L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
          L5_2 = L0_3
        end
        L0_3 = L3_2.x
        L1_3 = math
        L1_3 = L1_3.sin
        L2_3 = math
        L2_3 = L2_3.rad
        L3_3 = L6_2
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
        L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
        L2_3 = L4_2
        L1_3 = L1_3 * L2_3
        L0_3 = L0_3 + L1_3
        L11_2 = L0_3
        L0_3 = L3_2.y
        L1_3 = math
        L1_3 = L1_3.cos
        L2_3 = math
        L2_3 = L2_3.rad
        L3_3 = L6_2
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
        L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
        L2_3 = L4_2
        L1_3 = L1_3 * L2_3
        L0_3 = L0_3 + L1_3
        L12_2 = L0_3
        L0_3 = L3_2.z
        L1_3 = math
        L1_3 = L1_3.sin
        L2_3 = math
        L2_3 = L2_3.rad
        L3_3 = L5_2
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
        L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
        L2_3 = L4_2
        L1_3 = L1_3 * L2_3
        L0_3 = L0_3 + L1_3
        L13_2 = L0_3
        L0_3 = L13_2
        L1_3 = L3_2.z
        if L0_3 < L1_3 then
          L0_3 = L18_2
          L13_2 = L0_3
          L0_3 = L19_2
          L5_2 = L0_3
        end
        L0_3 = L13_2
        L18_2 = L0_3
        L0_3 = L5_2
        L19_2 = L0_3
        L0_3 = SetCamCoord
        L1_3 = CameraTrunkId
        L2_3 = L11_2
        L3_3 = L12_2
        L4_3 = L13_2
        L0_3(L1_3, L2_3, L3_3, L4_3)
        L0_3 = PointCamAtCoord
        L1_3 = CameraTrunkId
        L2_3 = L3_2.x
        L3_3 = L3_2.y
        L4_3 = L3_2.z
        L0_3(L1_3, L2_3, L3_3, L4_3)
      end
      L0_3 = Citizen
      L0_3 = L0_3.Wait
      L1_3 = 0
      L0_3(L1_3)
    end
  end
  L25_2(L26_2)
  ::lbl_98::
end
SetupCameraTrunk = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = RenderScriptCams
  L1_2 = false
  L2_2 = true
  L3_2 = 1000
  L4_2 = true
  L5_2 = false
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = DestroyCam
  L1_2 = CameraTrunkId
  L2_2 = false
  L0_2(L1_2, L2_2)
  CameraTrunkId = nil
  L0_2 = TriggerEvent
  L1_2 = "sf-trunks:isUsingCamera"
  L2_2 = false
  L0_2(L1_2, L2_2)
end
DisableCameraTrunk = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = PlayerPedId
  L0_2 = L0_2()
  L1_2 = ClearPedTasks
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = DetachEntity
  L2_2 = L0_2
  L3_2 = false
  L4_2 = false
  L1_2(L2_2, L3_2, L4_2)
end
DetachPed = L0_1
function L0_1(A0_2)
  local L1_2, L2_2
  L1_2 = HasAnimDictLoaded
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = RequestAnimDict
    L2_2 = A0_2
    L1_2(L2_2)
    while true do
      L1_2 = HasAnimDictLoaded
      L2_2 = A0_2
      L1_2 = L1_2(L2_2)
      if L1_2 then
        break
      end
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = 0
      L1_2(L2_2)
    end
  end
end
RequestAnimDict2 = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = SendNUIMessage
  L3_2 = {}
  L3_2.event = "sendAppEvent"
  L3_2.app = "os"
  L3_2.action = A0_2
  L3_2.payload = A1_2
  L2_2(L3_2)
end
SendNUIAppAction = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = PlayerPedId
  L0_2 = L0_2()
  L1_2 = ClearPedTasks
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = RequestAnimDict2
  L2_2 = "fin_ext_p1-7"
  L1_2(L2_2)
  L1_2 = TaskPlayAnim
  L2_2 = L0_2
  L3_2 = "fin_ext_p1-7"
  L4_2 = "cs_devin_dual-7"
  L5_2 = 8.0
  L6_2 = 8.0
  L7_2 = -1
  L8_2 = 2
  L9_2 = 999.0
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
PlayTrunkAnim = L0_1
L0_1 = false
L1_1 = AddStateBagChangeHandler
L2_1 = "InTrunk"
L3_1 = "player:%s"
L4_1 = L3_1
L3_1 = L3_1.format
L5_1 = MyServerId
L3_1 = L3_1(L4_1, L5_1)
function L4_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2
  if nil ~= A2_2 then
    L5_2 = L0_1
    if not L5_2 then
      L5_2 = true
      L0_1 = L5_2
      L5_2 = Citizen
      L5_2 = L5_2.CreateThreadNow
      function L6_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
        L0_3 = PlayerPedId
        L0_3 = L0_3()
        L1_3 = 0
        while true do
          L2_3 = InTrunk
          if not L2_3 then
            break
          end
          L1_3 = L1_3 + 1
          L2_3 = IsEntityPlayingAnim
          L3_3 = L0_3
          L4_3 = "fin_ext_p1-7"
          L5_3 = "cs_devin_dual-7"
          L6_3 = 3
          L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
          if not L2_3 then
            L2_3 = PlayTrunkAnim
            L2_3()
            L2_3 = Citizen
            L2_3 = L2_3.Wait
            L3_3 = 100
            L2_3(L3_3)
          end
          L2_3 = DisableAllControlActions2
          L2_3()
          L2_3 = 1
          L3_3 = Config
          L3_3 = L3_3.EnabledKeysWhileInTrunk
          L3_3 = #L3_3
          L4_3 = 1
          for L5_3 = L2_3, L3_3, L4_3 do
            L6_3 = EnableControlAction
            L7_3 = 0
            L8_3 = Config
            L8_3 = L8_3.EnabledKeysWhileInTrunk
            L8_3 = L8_3[L5_3]
            L9_3 = true
            L6_3(L7_3, L8_3, L9_3)
          end
          if L1_3 > 120 then
            L1_3 = 0
            L2_3 = DoesEntityExist
            L3_3 = TrunkVehicle
            L2_3 = L2_3(L3_3)
            if L2_3 then
              L2_3 = GetEntityCoords
              L3_3 = L0_3
              L2_3 = L2_3(L3_3)
              L3_3 = GetEntityCoords
              L4_3 = TrunkVehicle
              L3_3 = L3_3(L4_3)
              L2_3 = L2_3 - L3_3
              L2_3 = #L2_3
              if L2_3 > 30.0 then
                L2_3 = SetStateInTrunk
                L3_3 = LocalPlayer
                L3_3 = L3_3.state
                L3_3 = L3_3.InTrunk
                L4_3 = nil
                L5_3 = TrunkVehicle
                L2_3(L3_3, L4_3, L5_3)
                break
              end
              L2_3 = IsEntityDead
              L3_3 = TrunkVehicle
              L2_3 = L2_3(L3_3)
              if L2_3 then
                L2_3 = SetStateInTrunk
                L3_3 = LocalPlayer
                L3_3 = L3_3.state
                L3_3 = L3_3.InTrunk
                L4_3 = nil
                L5_3 = TrunkVehicle
                L2_3(L3_3, L4_3, L5_3)
                break
              end
              L2_3 = GetEntitySubmergedLevel
              L3_3 = TrunkVehicle
              L2_3 = L2_3(L3_3)
              L3_3 = 0.9
              if L2_3 > L3_3 then
                L2_3 = SetStateInTrunk
                L3_3 = LocalPlayer
                L3_3 = L3_3.state
                L3_3 = L3_3.InTrunk
                L4_3 = nil
                L5_3 = TrunkVehicle
                L2_3(L3_3, L4_3, L5_3)
                break
              end
            else
              L2_3 = SetStateInTrunk
              L3_3 = LocalPlayer
              L3_3 = L3_3.state
              L3_3 = L3_3.InTrunk
              L4_3 = nil
              L5_3 = TrunkVehicle
              L2_3(L3_3, L4_3, L5_3)
            end
          end
          L2_3 = Citizen
          L2_3 = L2_3.Wait
          L3_3 = 0
          L2_3(L3_3)
        end
        L2_3 = false
        L0_1 = L2_3
      end
      L5_2(L6_2)
    end
  end
end
L1_1(L2_1, L3_1, L4_1)
L1_1 = Config
L1_1 = L1_1.DevMode
if L1_1 then
  L1_1 = RegisterCommand
  L2_1 = "trunk_create"
  function L3_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_2 = GetClosestVehicle_T
    L2_2 = false
    L1_2 = L1_2(L2_2)
    L2_2 = TriggerEvent
    L3_2 = "sf-trunks:inEditor"
    L4_2 = true
    L2_2(L3_2, L4_2)
    L2_2 = SendNUIAppAction
    L3_2 = "setKeysVisible"
    L4_2 = true
    L2_2(L3_2, L4_2)
    L2_2 = SendNUIAppAction
    L3_2 = "setKeys"
    L4_2 = {}
    L5_2 = {}
    L6_2 = {}
    L7_2 = Config
    L7_2 = L7_2.OffsetEditorKeys
    L7_2 = L7_2.Position
    L7_2 = L7_2.Forward
    L7_2 = L7_2[2]
    L8_2 = Config
    L8_2 = L8_2.OffsetEditorKeys
    L8_2 = L8_2.Position
    L8_2 = L8_2.Backward
    L8_2 = L8_2[2]
    L9_2 = Config
    L9_2 = L9_2.OffsetEditorKeys
    L9_2 = L9_2.Position
    L9_2 = L9_2.Left
    L9_2 = L9_2[2]
    L10_2 = Config
    L10_2 = L10_2.OffsetEditorKeys
    L10_2 = L10_2.Position
    L10_2 = L10_2.Right
    L10_2 = L10_2[2]
    L11_2 = Config
    L11_2 = L11_2.OffsetEditorKeys
    L11_2 = L11_2.Position
    L11_2 = L11_2.Up
    L11_2 = L11_2[2]
    L12_2 = Config
    L12_2 = L12_2.OffsetEditorKeys
    L12_2 = L12_2.Position
    L12_2 = L12_2.Down
    L12_2 = L12_2[2]
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L6_2[3] = L9_2
    L6_2[4] = L10_2
    L6_2[5] = L11_2
    L6_2[6] = L12_2
    L5_2.keys = L6_2
    L6_2 = _L
    L7_2 = "position"
    L6_2 = L6_2(L7_2)
    L5_2.label = L6_2
    L6_2 = {}
    L7_2 = {}
    L8_2 = Config
    L8_2 = L8_2.OffsetEditorKeys
    L8_2 = L8_2.Rotation
    L8_2 = L8_2.XAxis
    L8_2 = L8_2.Plus
    L8_2 = L8_2[2]
    L9_2 = Config
    L9_2 = L9_2.OffsetEditorKeys
    L9_2 = L9_2.Rotation
    L9_2 = L9_2.XAxis
    L9_2 = L9_2.Minus
    L9_2 = L9_2[2]
    L10_2 = Config
    L10_2 = L10_2.OffsetEditorKeys
    L10_2 = L10_2.Rotation
    L10_2 = L10_2.YAxis
    L10_2 = L10_2.Plus
    L10_2 = L10_2[2]
    L11_2 = Config
    L11_2 = L11_2.OffsetEditorKeys
    L11_2 = L11_2.Rotation
    L11_2 = L11_2.YAxis
    L11_2 = L11_2.Minus
    L11_2 = L11_2[2]
    L12_2 = Config
    L12_2 = L12_2.OffsetEditorKeys
    L12_2 = L12_2.Rotation
    L12_2 = L12_2.ZAxis
    L12_2 = L12_2.Plus
    L12_2 = L12_2[2]
    L13_2 = Config
    L13_2 = L13_2.OffsetEditorKeys
    L13_2 = L13_2.Rotation
    L13_2 = L13_2.ZAxis
    L13_2 = L13_2.Minus
    L13_2 = L13_2[2]
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L7_2[3] = L10_2
    L7_2[4] = L11_2
    L7_2[5] = L12_2
    L7_2[6] = L13_2
    L6_2.keys = L7_2
    L7_2 = _L
    L8_2 = "rotation"
    L7_2 = L7_2(L8_2)
    L6_2.label = L7_2
    L7_2 = {}
    L8_2 = {}
    L9_2 = Config
    L9_2 = L9_2.OffsetEditorKeys
    L9_2 = L9_2.OpenAllVehicleDoors
    L9_2 = L9_2[2]
    L8_2[1] = L9_2
    L7_2.keys = L8_2
    L8_2 = _L
    L9_2 = "openAllVehicleDoors"
    L8_2 = L8_2(L9_2)
    L7_2.label = L8_2
    L8_2 = {}
    L9_2 = {}
    L10_2 = Config
    L10_2 = L10_2.OffsetEditorKeys
    L10_2 = L10_2.Confirm
    L10_2 = L10_2[2]
    L9_2[1] = L10_2
    L8_2.keys = L9_2
    L9_2 = _L
    L10_2 = "confirm"
    L9_2 = L9_2(L10_2)
    L8_2.label = L9_2
    L9_2 = {}
    L10_2 = {}
    L11_2 = Config
    L11_2 = L11_2.OffsetEditorKeys
    L11_2 = L11_2.Cancel
    L11_2 = L11_2[2]
    L10_2[1] = L11_2
    L9_2.keys = L10_2
    L10_2 = _L
    L11_2 = "cancel"
    L10_2 = L10_2(L11_2)
    L9_2.label = L10_2
    L4_2[1] = L5_2
    L4_2[2] = L6_2
    L4_2[3] = L7_2
    L4_2[4] = L8_2
    L4_2[5] = L9_2
    L2_2(L3_2, L4_2)
    L2_2 = SetupCameraTrunk
    L3_2 = L0_2
    L4_2 = L1_2
    L2_2(L3_2, L4_2)
    L2_2 = RequestAnimDict2
    L3_2 = "fin_ext_p1-7"
    L2_2(L3_2)
    L2_2 = TaskPlayAnim
    L3_2 = L0_2
    L4_2 = "fin_ext_p1-7"
    L5_2 = "cs_devin_dual-7"
    L6_2 = 8.0
    L7_2 = 8.0
    L8_2 = -1
    L9_2 = 2
    L10_2 = 999.0
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L2_2 = GetModelDimensions
    L3_2 = GetEntityModel
    L4_2 = L1_2
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2 = L3_2(L4_2)
    L2_2, L3_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
    L4_2 = AttachEntityToEntity
    L5_2 = L0_2
    L6_2 = L1_2
    L7_2 = 0
    L8_2 = 0.0
    L9_2 = L2_2.y
    L9_2 = L9_2 - 0.3
    L10_2 = 0.0
    L11_2 = 0.0
    L12_2 = 0.0
    L13_2 = 0.0
    L14_2 = true
    L15_2 = true
    L16_2 = false
    L17_2 = true
    L18_2 = 1
    L19_2 = true
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L4_2 = false
    L5_2 = 0.0
    L6_2 = L2_2.y
    L6_2 = L6_2 - 0.3
    L7_2 = 0.0
    L8_2 = 0.0
    L9_2 = 0.0
    L10_2 = 0.0
    L11_2 = false
    L12_2 = false
    L13_2 = DisableIdleCamera
    L14_2 = false
    L13_2(L14_2)
    while true do
      L4_2 = false
      L13_2 = DisableAllControlActions2
      L13_2()
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 270
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 271
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 272
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 273
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 1
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 2
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 3
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 4
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 5
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = EnableControlAction
      L14_2 = 1
      L15_2 = 6
      L16_2 = true
      L13_2(L14_2, L15_2, L16_2)
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Position
      L15_2 = L15_2.Right
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L5_2 = L5_2 + 0.005
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Position
      L15_2 = L15_2.Left
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L5_2 = L5_2 - 0.005
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Position
      L15_2 = L15_2.Forward
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L6_2 = L6_2 + 0.005
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Position
      L15_2 = L15_2.Backward
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L6_2 = L6_2 - 0.005
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Position
      L15_2 = L15_2.Up
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L7_2 = L7_2 + 0.005
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Position
      L15_2 = L15_2.Down
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L7_2 = L7_2 - 0.005
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Rotation
      L15_2 = L15_2.XAxis
      L15_2 = L15_2.Plus
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L8_2 = L8_2 + 0.5
        L13_2 = 180.0
        if L8_2 > L13_2 then
          L8_2 = 0.0
        end
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Rotation
      L15_2 = L15_2.XAxis
      L15_2 = L15_2.Minus
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L8_2 = L8_2 - 0.5
        L13_2 = -180.0
        if L8_2 < L13_2 then
          L8_2 = 0.0
        end
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Rotation
      L15_2 = L15_2.YAxis
      L15_2 = L15_2.Plus
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L9_2 = L9_2 + 0.5
        L13_2 = 180.0
        if L9_2 > L13_2 then
          L9_2 = 0.0
        end
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Rotation
      L15_2 = L15_2.YAxis
      L15_2 = L15_2.Minus
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L9_2 = L9_2 - 0.5
        L13_2 = -180.0
        if L9_2 < L13_2 then
          L9_2 = 0.0
        end
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Rotation
      L15_2 = L15_2.ZAxis
      L15_2 = L15_2.Plus
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L10_2 = L10_2 + 0.5
        L13_2 = 180.0
        if L10_2 > L13_2 then
          L10_2 = 0.0
        end
        L4_2 = true
      end
      L13_2 = IsDisabledControlPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Rotation
      L15_2 = L15_2.ZAxis
      L15_2 = L15_2.Minus
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L10_2 = L10_2 - 0.5
        L13_2 = -180.0
        if L10_2 < L13_2 then
          L10_2 = 0.0
        end
        L4_2 = true
      end
      L13_2 = IsDisabledControlJustPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Confirm
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L11_2 = true
        break
      end
      L13_2 = IsDisabledControlJustPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.Cancel
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        L11_2 = false
        break
      end
      L13_2 = IsDisabledControlJustPressed
      L14_2 = 0
      L15_2 = Config
      L15_2 = L15_2.OffsetEditorKeys
      L15_2 = L15_2.OpenAllVehicleDoors
      L15_2 = L15_2[1]
      L13_2 = L13_2(L14_2, L15_2)
      if L13_2 then
        if not L12_2 then
          L12_2 = true
          L13_2 = 0
          L14_2 = 5
          L15_2 = 1
          for L16_2 = L13_2, L14_2, L15_2 do
            L17_2 = SetVehicleDoorOpen
            L18_2 = L1_2
            L19_2 = L16_2
            L20_2 = false
            L21_2 = false
            L17_2(L18_2, L19_2, L20_2, L21_2)
          end
        else
          L12_2 = false
          L13_2 = 0
          L14_2 = 5
          L15_2 = 1
          for L16_2 = L13_2, L14_2, L15_2 do
            L17_2 = SetVehicleDoorShut
            L18_2 = L1_2
            L19_2 = L16_2
            L20_2 = false
            L17_2(L18_2, L19_2, L20_2)
          end
        end
      end
      if L4_2 then
        L13_2 = AttachEntityToEntity
        L14_2 = L0_2
        L15_2 = L1_2
        L16_2 = 0
        L17_2 = L5_2
        L18_2 = L6_2
        L19_2 = L7_2
        L20_2 = L8_2
        L21_2 = L9_2
        L22_2 = L10_2
        L23_2 = true
        L24_2 = true
        L25_2 = false
        L26_2 = true
        L27_2 = 1
        L28_2 = true
        L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
        L13_2 = TaskPlayAnim
        L14_2 = L0_2
        L15_2 = "fin_ext_p1-7"
        L16_2 = "cs_devin_dual-7"
        L17_2 = 8.0
        L18_2 = 8.0
        L19_2 = -1
        L20_2 = 2
        L21_2 = 999.0
        L22_2 = false
        L23_2 = false
        L24_2 = false
        L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      end
      L13_2 = Citizen
      L13_2 = L13_2.Wait
      L14_2 = 0
      L13_2(L14_2)
    end
    if L12_2 then
      L13_2 = 0
      L14_2 = 5
      L15_2 = 1
      for L16_2 = L13_2, L14_2, L15_2 do
        L17_2 = SetVehicleDoorShut
        L18_2 = L1_2
        L19_2 = L16_2
        L20_2 = false
        L17_2(L18_2, L19_2, L20_2)
      end
    end
    L13_2 = Citizen
    L13_2 = L13_2.CreateThreadNow
    function L14_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L0_3 = 1
      L1_3 = 40
      L2_3 = 1
      for L3_3 = L0_3, L1_3, L2_3 do
        L4_3 = DisableControlAction
        L5_3 = 0
        L6_3 = 177
        L7_3 = true
        L4_3(L5_3, L6_3, L7_3)
        L4_3 = DisableControlAction
        L5_3 = 0
        L6_3 = 200
        L7_3 = true
        L4_3(L5_3, L6_3, L7_3)
        L4_3 = DisableControlAction
        L5_3 = 0
        L6_3 = 202
        L7_3 = true
        L4_3(L5_3, L6_3, L7_3)
        L4_3 = DisableControlAction
        L5_3 = 0
        L6_3 = 322
        L7_3 = true
        L4_3(L5_3, L6_3, L7_3)
        L4_3 = Citizen
        L4_3 = L4_3.Wait
        L5_3 = 0
        L4_3(L5_3)
      end
    end
    L13_2(L14_2)
    if L11_2 then
      L13_2 = TriggerServerEvent
      L14_2 = "sf-trunks:saveConfig"
      L15_2 = GetEntityModel
      L16_2 = L1_2
      L15_2 = L15_2(L16_2)
      L16_2 = vec3
      L17_2 = L5_2
      L18_2 = L6_2
      L19_2 = L7_2
      L16_2 = L16_2(L17_2, L18_2, L19_2)
      L17_2 = vec3
      L18_2 = L8_2
      L19_2 = L9_2
      L20_2 = L10_2
      L17_2 = L17_2(L18_2, L19_2, L20_2)
      L18_2 = GetAllVehicleModels
      L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2 = L18_2()
      L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
    end
    L13_2 = DisableCameraTrunk
    L13_2()
    L13_2 = DetachEntity
    L14_2 = L0_2
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = ClearPedTasks
    L14_2 = L0_2
    L13_2(L14_2)
    L13_2 = GetOffsetFromEntityInWorldCoords
    L14_2 = L1_2
    L15_2 = 0.0
    L16_2 = L2_2.y
    L16_2 = L16_2 - 1.0
    L17_2 = 0.1
    L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2)
    L14_2 = SetEntityCoords
    L15_2 = L0_2
    L16_2 = L13_2.x
    L17_2 = L13_2.y
    L18_2 = L13_2.z
    L19_2 = false
    L20_2 = false
    L21_2 = false
    L22_2 = false
    L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L14_2 = PlaceObjectOnGroundProperly
    L15_2 = L0_2
    L14_2(L15_2)
    L14_2 = SendNUIAppAction
    L15_2 = "setKeysVisible"
    L16_2 = false
    L14_2(L15_2, L16_2)
    L14_2 = TriggerEvent
    L15_2 = "sf-trunks:inEditor"
    L16_2 = false
    L14_2(L15_2, L16_2)
  end
  L4_1 = false
  L1_1(L2_1, L3_1, L4_1)
end
